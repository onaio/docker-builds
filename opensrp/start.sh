#!/bin/bash
set -eo pipefail
shopt -s nullglob

# Initialize MySQL
MYSQL_COMMAND="mysqld"

_check_config() {
	toRun=( "$MYSQL_COMMAND" --verbose --help --log-bin-index="$(mktemp -u)" )
	if ! errors="$("${toRun[@]}" 2>&1 >/dev/null)"; then
		cat >&2 <<-EOM

			ERROR: mysqld failed while attempting to check config
			command was: "${toRun[*]}"

			$errors
		EOM
		exit 1
	fi
}

_datadir() {
	"$MYSQL_COMMAND" --verbose --help --log-bin-index="$(mktemp -u)" 2>/dev/null | awk '$1 == "datadir" { print $2; exit }'
}

# allow the container to be started with `--user`
if [ -a "$(id -u)" = '0' ]; then
	_check_config "$MYSQL_COMMAND"
	DATADIR="$(_datadir "$MYSQL_COMMAND")"
	mkdir -p "$DATADIR"
	chown -R mysql:mysql "$DATADIR"
	exec gosu mysql "$BASH_SOURCE" "$MYSQL_COMMAND"
fi

# still need to check config, container may have started with --user
_check_config "$MYSQL_COMMAND"
# Get config
DATADIR="$(_datadir "$MYSQL_COMMAND")"

if [ ! -d "$DATADIR/mysql" ]; then
	if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" -a -z "$MYSQL_RANDOM_ROOT_PASSWORD" ]; then
		echo >&2 'error: database is uninitialized and password option is not specified '
		echo >&2 '  You need to specify one of MYSQL_ROOT_PASSWORD, MYSQL_ALLOW_EMPTY_PASSWORD and MYSQL_RANDOM_ROOT_PASSWORD'
		exit 1
	fi

	mkdir -p "$DATADIR"
    echo "DATADIR: $DATADIR"

	echo 'Initializing database'
	mysql_install_db --datadir="$DATADIR" --rpm --keep-my-cnf
	echo 'Database initialized'

	"$MYSQL_COMMAND" --skip-networking &
	pid="$!"

	mysql=( mysql --protocol=socket -uroot )

	for i in {30..0}; do
		if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
			break
		fi
		echo 'MySQL init process in progress...'
		sleep 1
	done
	if [ "$i" = 0 ]; then
		echo >&2 'MySQL init process failed.'
		exit 1
	fi

	if [ -z "$MYSQL_INITDB_SKIP_TZINFO" ]; then
		# sed is for https://bugs.mysql.com/bug.php?id=20545
		mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/FCTY/' | "${mysql[@]}" mysql
	fi

	if [ ! -z "$MYSQL_RANDOM_ROOT_PASSWORD" ]; then
		MYSQL_ROOT_PASSWORD="$(pwgen -1 32)"
		echo "GENERATED ROOT PASSWORD: $MYSQL_ROOT_PASSWORD"
	fi
	"${mysql[@]}" <<-EOSQL
		-- What's done in this file shouldn't be replicated
		--  or products like mysql-fabric won't work
		SET @@SESSION.SQL_LOG_BIN=0;

		DELETE FROM mysql.user ;
		CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
		GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
		DROP DATABASE IF EXISTS test ;
		FLUSH PRIVILEGES ;
	EOSQL

	if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
		mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
	fi


	if [ "$MYSQL_MOTECH_DATABASE" ]; then
		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_MOTECH_DATABASE\` ;" | "${mysql[@]}"
	fi

	if [ "$MYSQL_OPENMRS_DATABASE" ]; then
		echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_OPENMRS_DATABASE\` ;" | "${mysql[@]}"
		mysql+=( "$MYSQL_OPENMRS_DATABASE" )
	fi

	if [ "$MYSQL_OPENMRS_USER" -a "$MYSQL_OPENMRS_PASSWORD" ]; then
		echo "CREATE USER '$MYSQL_OPENMRS_USER'@'%' IDENTIFIED BY '$MYSQL_OPENMRS_PASSWORD' ;" | "${mysql[@]}"

		if [ "$MYSQL_OPENMRS_DATABASE" ]; then
			echo "GRANT ALL ON \`$MYSQL_OPENMRS_DATABASE\`.* TO '$MYSQL_OPENMRS_USER'@'%' ;" | "${mysql[@]}"
		fi

		echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
	fi

	echo
	for f in /docker-entrypoint-initdb.d/*; do
		case "$f" in
			*.sh)     echo "$0: running $f"; . "$f" ;;
			*.sql)    echo "$0: running $f"; "${mysql[@]}" < "$f"; echo ;;
			*.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
			*)        echo "$0: ignoring $f" ;;
		esac
		echo
	done

	if [ ! -z "$MYSQL_ONETIME_PASSWORD" ]; then
		"${mysql[@]}" <<-EOSQL
			ALTER USER 'root'@'%' PASSWORD EXPIRE;
		EOSQL
	fi

	# Import data
	mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_MOTECH_DATABASE" < "~/sql/tables_quartz_mysql.sql"
	mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_OPENMRS_DATABASE" < "~/sql/openmrs.sql"
	mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_OPENMRS_DATABASE" < "~/sql/locations.sql"
	mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_OPENMRS_DATABASE" < "~/sql/person_attribute_type.sql"

	# create openmrs properties file
	touch /root/.OpenMRS/openmrs-runtime.properties
	cat > /root/.OpenMRS/openmrs-runtime.properties <<- EOF
		connection.username=${MYSQL_OPENMRS_USER}
		connection.password=${MYSQL_OPENMRS_PASSWORD}
		connection.url=jdbc:mysql://localhost:3306/${MYSQL_OPENMRS_DATABASE}?autoReconnect=true&sessionVariables=storage_engine=InnoDB&useUnicode=true&characterEncoding=UTF-8
		module.allow_web_admin=true
		auto_update_database=false
	EOF

	if ! kill -s TERM "$pid" || ! wait "$pid"; then
		echo >&2 'MySQL init process failed.'
		exit 1
	fi

	echo
	echo 'MySQL init process done. Ready for start up.'
	echo
fi

# Finished MySQL Initialization

# Initialize CouchDB

# we need to set the permissions here because docker mounts volumes as root
chown -R couchdb:couchdb \
	/usr/local/var/lib/couchdb \
	/usr/local/var/log/couchdb \
	/usr/local/var/run/couchdb \
	/usr/local/etc/couchdb

chmod -R 0770 \
	/usr/local/var/lib/couchdb \
	/usr/local/var/log/couchdb \
	/usr/local/var/run/couchdb \
	/usr/local/etc/couchdb

chmod 664 /usr/local/etc/couchdb/*.ini
chmod 775 /usr/local/etc/couchdb/*.d

if [ "$COUCHDB_USER" ] && [ "$COUCHDB_PASSWORD" ]; then
	# Create admin
	printf "[admins]\n$COUCHDB_USER = $COUCHDB_PASSWORD\n" > /usr/local/etc/couchdb/local.d/docker.ini
	chown couchdb:couchdb /usr/local/etc/couchdb/local.d/docker.ini
fi

# if we don't find an [admins] section followed by a non-comment, display a warning
if ! grep -Pzoqr '\[admins\]\n[^;]\w+' /usr/local/etc/couchdb; then
	# The - option suppresses leading tabs but *not* spaces. :)
	cat >&2 <<-'EOWARN'
		****************************************************
		WARNING: CouchDB is running in Admin Party mode.
		         This will allow anyone with access to the
		         CouchDB port to access your database. In
		         Docker's default configuration, this is
		         effectively any other container on the same
		         system.
		         Use "-e COUCHDB_USER=admin -e COUCHDB_PASSWORD=password"
		         to set it in "docker run".
		****************************************************
	EOWARN
fi

# Finished CouchDB Initialization

# Initialize CouchDB Lucene

chown -R couchdb:couchdb /opt/couchdb-lucene

# Finished CouchDB Lucene Initialization

exec /usr/bin/supervisord

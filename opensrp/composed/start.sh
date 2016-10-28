#!/bin/bash

# Import data

mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h mysql -e "CREATE DATABASE $MYSQL_MOTECH_DATABASE /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h mysql "$MYSQL_MOTECH_DATABASE" < "~/sql/tables_quartz_mysql.sql"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h mysql "$MYSQL_OPENMRS_DATABASE" < "~/sql/openmrs.sql"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h mysql "$MYSQL_OPENMRS_DATABASE" < "~/sql/locations.sql"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -h mysql "$MYSQL_OPENMRS_DATABASE" < "~/sql/person_attribute_type.sql"

# create openmrs properties file
touch /root/.OpenMRS/openmrs-runtime.properties
cat > /root/.OpenMRS/openmrs-runtime.properties <<- EOF
	connection.username=${MYSQL_OPENMRS_USER}
	connection.password=${MYSQL_OPENMRS_PASSWORD}
	connection.url=jdbc:mysql://mysql:3306/${MYSQL_OPENMRS_DATABASE}?autoReconnect=true&sessionVariables=storage_engine=InnoDB&useUnicode=true&characterEncoding=UTF-8
	module.allow_web_admin=true
	auto_update_database=false
EOF

exec /usr/bin/supervisord

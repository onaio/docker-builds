FROM ubuntu:trusty

MAINTAINER Ephraim Muhia (emuhia@ona.io)

# Install mysql

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

# add gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true \
	&& apt-get purge -y --auto-remove ca-certificates

RUN mkdir /docker-entrypoint-initdb.d

# FATAL ERROR: please install the following Perl modules before executing /usr/local/mysql/scripts/mysql_install_db:
# File::Basename
# File::Copy
# Sys::Hostname
# Data::Dumper
RUN apt-get update && apt-get install -y perl pwgen --no-install-recommends && rm -rf /var/lib/apt/lists/*

# gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys A4A9406876FCBD3C456770C88C718D3B5072E1F5

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-5.6 \
 && rm -rf /var/lib/apt/lists/* \
	&& rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql /var/run/mysqld \
	&& chown -R mysql:mysql /var/lib/mysql /var/run/mysqld 

# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
	&& echo 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
	&& mv /tmp/my.cnf /etc/mysql/my.cnf

RUN cp /etc/mysql/my.cnf /usr/share/mysql/my-default.cnf

VOLUME /var/lib/mysql

EXPOSE 3306

# Installing supervisord
RUN apt-get update && apt-get install -y supervisor

RUN mkdir -p /var/log/supervisor

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Installing couchdb

# Install instructions from https://cwiki.apache.org/confluence/display/COUCHDB/Debian

RUN groupadd -r couchdb && useradd -d /var/lib/couchdb -g couchdb couchdb

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    erlang-nox \
    libicu52 \
    libmozjs185-1.0 \
    libnspr4 \
    libnspr4-0d \
  && rm -rf /var/lib/apt/lists/*

# https://www.apache.org/dist/couchdb/KEYS
ENV GPG_KEYS \
  15DD4F3B8AACA54740EB78C7B7B7C53943ECCEE1 \
  1CFBFA43C19B6DF4A0CA3934669C02FFDF3CEBA3 \
  25BBBAC113C1BFD5AA594A4C9F96B92930380381 \
  4BFCA2B99BADC6F9F105BEC9C5E32E2D6B065BFB \
  5D680346FAA3E51B29DBCB681015F68F9DA248BC \
  7BCCEB868313DDA925DF1805ECA5BCB7BB9656B0 \
  C3F4DFAEAD621E1C94523AEEC376457E61D50B88 \
  D2B17F9DA23C0A10991AF2E3D9EE01E47852AEE4 \
  E0AF0A194D55C84E4A19A801CDB0C0F904F4EE9B
RUN set -xe \
  && for key in $GPG_KEYS; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV COUCHDB_VERSION 1.6.1

# download dependencies, compile and install couchdb,
# set correct permissions, expose couchdb to the outside and disable logging to disk
RUN buildDeps=' \
    gcc \
    g++ \
    erlang-dev \
    libcurl4-openssl-dev \
    libicu-dev \
    libmozjs185-dev \
    libnspr4-dev \
    make \
  ' \
  && apt-get update && apt-get install -y --no-install-recommends $buildDeps \
  && curl -fSL http://apache.osuosl.org/couchdb/source/$COUCHDB_VERSION/apache-couchdb-$COUCHDB_VERSION.tar.gz -o couchdb.tar.gz \
  && curl -fSL https://www.apache.org/dist/couchdb/source/$COUCHDB_VERSION/apache-couchdb-$COUCHDB_VERSION.tar.gz.asc -o couchdb.tar.gz.asc \
  && gpg --verify couchdb.tar.gz.asc \
  && mkdir -p /usr/src/couchdb \
  && tar -xzf couchdb.tar.gz -C /usr/src/couchdb --strip-components=1 \
  && cd /usr/src/couchdb \
  && ./configure --with-js-lib=/usr/lib --with-js-include=/usr/include/mozjs \
  && make && make install \
  && apt-get purge -y --auto-remove $buildDeps \
  && rm -rf /var/lib/apt/lists/* /usr/src/couchdb /couchdb.tar.gz* \
  && chown -R couchdb:couchdb \
    /usr/local/lib/couchdb /usr/local/etc/couchdb \
    /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb \
  && chmod -R g+rw \
    /usr/local/lib/couchdb /usr/local/etc/couchdb \
    /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb \
  && mkdir -p /var/lib/couchdb \
  && sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /usr/local/etc/couchdb/default.ini \
  && sed -e 's!/usr/local/var/log/couchdb/couch.log$!/dev/null!' -i /usr/local/etc/couchdb/default.ini

# Define mountable directories.
VOLUME ["/usr/local/var/lib/couchdb"]

EXPOSE 5984

# Installing CouchDB lucene
ENV COUCHDB_LUCENE_VERSION 1.1.0

RUN apt-get update \
  && apt-get install -y maven \
  && cd /usr/src \
  && curl -L https://github.com/rnewson/couchdb-lucene/archive/v$COUCHDB_LUCENE_VERSION.tar.gz | tar -xz \
  && cd couchdb-lucene-$COUCHDB_LUCENE_VERSION \
  && mvn \
  && cd /usr/src/couchdb-lucene-$COUCHDB_LUCENE_VERSION/target \
  && unzip couchdb-lucene-$COUCHDB_LUCENE_VERSION-dist.zip \
  && mv couchdb-lucene-$COUCHDB_LUCENE_VERSION /opt/couchdb-lucene \
  && rm -rf /usr/src/couchdb-lucene-* \
  && apt-get remove --auto-remove -y maven \
  && rm -rf /var/lib/apt/lists/* \
  && sed -e 's/^host=localhost$/host=0.0.0.0/' -i /opt/couchdb-lucene/conf/couchdb-lucene.ini \
  && sed -e 's/localhost:5984/127.0.0.1:5984/' -i /opt/couchdb-lucene/conf/couchdb-lucene.ini \
  && chown -R couchdb:couchdb /opt/couchdb-lucene

# Link with lucene with couchdb
RUN sed -i -e '$a [couchdb]' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a os_process_timeout=60000 ; increase the timeout from 5 seconds. ' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a [external]' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a fti=/usr/bin/python /opt/couchdb-lucene/tools/couchdb-external-hook.py' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a [httpd_db_handlers]' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a _fti = {couch_httpd_external, handle_external_req, <<"fti">>}' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a [httpd_global_handlers]' /usr/local/etc/couchdb/local.ini
RUN sed -i -e '$a _fti = {couch_httpd_proxy, handle_proxy_req, <<"http:\/\/127.0.0.1:5985">>}' /usr/local/etc/couchdb/local.ini

VOLUME ["/opt/couchdb-lucene/indexes"]

EXPOSE 5985

#Installing activemQ
ENV ACTIVEMQ_VERSION 5.11.1
ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION

ENV ACTIVEMQ_HOME /opt/activemq
ENV ACTIVEMQ_CONF=${ACTIVEMQ_HOME}/conf
ENV ACTIVEMQ_DATA=${ACTIVEMQ_HOME}/data

RUN \
    curl -O http://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz && \
    mkdir -p /opt && \
    tar xf $ACTIVEMQ-bin.tar.gz -C /opt/ && \
    rm $ACTIVEMQ-bin.tar.gz && \
    ln -s /opt/$ACTIVEMQ $ACTIVEMQ_HOME && \
    useradd -r -M -d $ACTIVEMQ_HOME activemq && \
    chown activemq:activemq /opt/$ACTIVEMQ -R

VOLUME ["${ACTIVEMQ_CONF}", "${ACTIVEMQ_DATA}"]

EXPOSE 61616 8161

# Install tomcat
ENV TOMCAT_VERSION 7.0.72
# Get Tomcat
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /opt && \
mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
rm /tmp/tomcat.tgz && \
rm -rf /opt/tomcat/webapps/examples && \
rm -rf /opt/tomcat/webapps/docs && \
rm -rf /opt/tomcat/webapps/ROOT

# Download openmrs war and modules
RUN curl -O http://liquidtelecom.dl.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_1.11.5/openmrs.war && \
mv openmrs.war /opt/tomcat/webapps && \
mkdir /root/.OpenMRS && \
curl -O http://netcologne.dl.sourceforge.net/project/keymane/opensrp/opensrp_openmrs_modules.tar.gz && \
tar xzvf opensrp_openmrs_modules.tar.gz  -C /root/.OpenMRS

ENV CATALINA_HOME /opt/tomcat

ENV PATH $PATH:$CATALINA_HOME/bin

VOLUME "/opt/tomcat/webapps"

EXPOSE 8080

# Copying files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY composed/sql ~/sql

COPY start.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/start.sh"]
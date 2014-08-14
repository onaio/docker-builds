FROM ubuntu

MAINTAINER Ukang'a Dickson


ENV CODENAME trusty
RUN echo "deb http://archive.ubuntu.com/ubuntu $CODENAME main universe" > /etc/apt/sources.list
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $CODENAME-pgdg main" > /etc/apt/sources.list.d/pgdg.list
ADD apt.postgresql.org.gpg /apt.postgresql.org.gpg
ENV KEYRING /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg
RUN test -e $KEYRING || touch $KEYRING
RUN apt-key --keyring $KEYRING add /apt.postgresql.org.gpg
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3-postgis-2.1 postgresql-9.3-postgis-script postgis

ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf 
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf


# Cleanup
RUN apt-get clean

EXPOSE 5432

USER postgres

CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf", "-c", "listen_addresses=*"]

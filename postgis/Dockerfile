FROM ubuntu

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>


ENV CODENAME trusty
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $CODENAME-pgdg main" > /etc/apt/sources.list.d/pgdg.list
ADD apt.postgresql.org.gpg /apt.postgresql.org.gpg
ENV KEYRING /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg
RUN test -e $KEYRING || touch $KEYRING
RUN apt-key --keyring $KEYRING add /apt.postgresql.org.gpg && \
        apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.4-postgis-2.1 postgresql-9.4-postgis-script postgis && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y postgresql-9.3-postgis-2.1 postgresql-9.3-postgis-script postgis

ADD pg_hba.conf /etc/postgresql/9.4/main/pg_hba.conf
ADD postgresql.conf /etc/postgresql/9.4/main/postgresql.conf
ADD start /start
RUN chmod +x /start


# Cleanup
RUN apt-get clean

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

EXPOSE 5432

CMD ["/start"]

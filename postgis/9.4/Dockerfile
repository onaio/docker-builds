FROM ubuntu:14.04.4

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>


RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
  && apt-get install -y --force-yes wget ca-certificates \
  && apt-get update  \
  &&  DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes postgresql-9.4-postgis-2.1 postgresql-9.4-postgis-script postgis

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

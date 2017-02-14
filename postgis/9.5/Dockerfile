FROM ubuntu:14.04.4

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>


RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
  && apt-get update  \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes wget ca-certificates \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes postgresql-9.5-postgis-2.3 postgresql-9.5-postgis-script postgis

ADD pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
ADD postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
ADD start /start
RUN chmod +x /start


# Cleanup
RUN apt-get clean

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive locale-gen en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

EXPOSE 5432

CMD ["/start"]

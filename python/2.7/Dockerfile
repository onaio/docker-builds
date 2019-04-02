FROM ubuntu:16.04

MAINTAINER Ukang'a Dickson

# we need postgres client
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y wget ca-certificates \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
  && DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y  locales postgresql-client-9.5 python python-dev python-setuptools python-pip git-core libpq-dev libproj-dev gdal-bin wget python-software-properties software-properties-common libx11-dev libsqlite3-dev libmemcached-dev zlib1g-dev openjdk-8-jre-headless \
  && rm -rf /var/lib/apt/lists/*

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN sed --in-place '/en_US.UTF-8/s/^# //' /etc/locale.gen
RUN locale-gen en_US.UTF-8
RUN easy_install pip

CMD ["python2"]


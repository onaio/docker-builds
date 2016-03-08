FROM ubuntu:14.04.4

MAINTAINER Ukang'a Dickson

# we need postgres client
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
&& apt-get install -y --force-yes wget ca-certificates \
&& DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y --force-yes  postgresql-client-9.4 python python-dev python-setuptools python-pip git-core libpq-dev libproj-dev gdal-bin wget python-software-properties software-properties-common libx11-dev libsqlite3-dev \
  && rm -rf /var/lib/apt/lists/*

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
RUN easy_install pip

CMD ["python2"]


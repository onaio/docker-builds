FROM ubuntu

MAINTAINER Ukang'a Dickson

RUN apt-get update -qq

# required by drone ci
RUN apt-get install -yqq socat

# we need postgres client
RUN apt-get install -yqq  postgresql-client-9.3

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq python3 python3-dev python3-setuptools python3-pip git-core libpq-dev libproj-dev gdal-bin

RUN apt-get clean

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

CMD ["python3"]


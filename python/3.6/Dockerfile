FROM ubuntu

MAINTAINER Ukang'a Dickson

RUN apt-get update -qq

# For python 3.6
RUN apt-get install -yqq software-properties-common
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update -qq

# required by drone ci
RUN apt-get install -yqq socat

# we need postgres client
RUN apt-get install -yqq  postgresql-client-9.5

RUN DEBIAN_FRONTEND=noninteractive apt-get install -yqq python3.6 python3.6-dev python3-setuptools python3-pip python3.6-venv \
  git-core libpq-dev libproj-dev gdal-bin locales

RUN apt-get clean

RUN locale-gen en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN dpkg-reconfigure locales

RUN LC_ALL=C python3.6 -m pip install pip --upgrade
RUN LC_ALL=C python3.6 -m pip install wheel --upgrade

CMD ["python3"]


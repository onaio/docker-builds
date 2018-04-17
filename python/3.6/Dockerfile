FROM ubuntu:16.04

LABEL description="Python 2 under a virtualenv with postgresql dev and client libraries as well as sqlite dev libraries."

RUN apt-get update -qq

RUN DEBIAN_INTERACTIVE=noninteractive apt-get update \
  && apt-get install -y wget ca-certificates \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add - \
  && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
  && apt-get update

# For python 3.6
RUN apt-get install -yqq software-properties-common \
  && add-apt-repository ppa:jonathonf/python-3.6 \
  && apt-get update -qq

# required by drone ci
RUN apt-get install -yqq socat

RUN DEBIAN_INTERACTIVE=noninteractive apt-get install -y python3.6 python3.6-dev python3-setuptools python3.6-venv \
  postgresql-client-9.5 libpq-dev libproj-dev gdal-bin libsqlite3-dev \
  libtool gcc cmake librabbitmq-dev pkg-config automake \
  zlib1g-dev libmemcached-dev libxml2-dev libxslt1-dev libjpeg-dev \
  default-jre-headless git-core locales \
  && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN python3.6 -m venv .venv
ENV PATH /.venv/bin:$PATH

CMD ["python"]


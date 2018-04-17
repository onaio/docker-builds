FROM ubuntu:16.04

LABEL description="Python 2 under a virtualenv with postgresql dev and client libraries as well as sqlite dev libraries."

RUN DEBIAN_INTERACTIVE=noninteractive apt-get update \
  && apt-get install -y wget ca-certificates \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  apt-key add - \
  && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list' \
  && apt-get update
RUN DEBIAN_INTERACTIVE=noninteractive apt-get install -y python-dev python-setuptools python-virtualenv git-core postgresql-client-9.5 libpq-dev libproj-dev gdal-bin libsqlite3-dev locales\
  && rm -rf /var/lib/apt/lists/*

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN virtualenv --python=/usr/bin/python2.7 .venv
ENV PATH /.venv/bin:$PATH

CMD ["python"]

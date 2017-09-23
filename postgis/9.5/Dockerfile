FROM postgres:9.5

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>


RUN apt-get update \
  &&  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y postgresql-9.5-postgis-2.3 \
    postgresql-9.5-postgis-script \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432

CMD ["postgres"]

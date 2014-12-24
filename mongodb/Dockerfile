FROM ubuntu

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>

RUN apt-get update -y && apt-get install -y mongodb

# Cleanup
RUN apt-get clean

ADD start /start
RUN chmod 0755 /start
RUN mkdir -p /data/db

VOLUME ["/data"]

EXPOSE 27017

CMD ["/start"]

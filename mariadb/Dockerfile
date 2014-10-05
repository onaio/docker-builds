FROM ubuntu

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>

RUN echo "deb http://ftp.osuosl.org/pub/mariadb/repo/5.5/ubuntu precise main" > /etc/apt/sources.list.d/mariadb.list
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

# RUN /sbin/ip route | awk '/default/ { print "Acquire::http::Proxy \"http://"$3":8080\";" }' > /etc/apt/apt.conf.d/30proxy

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y net-tools mariadb-server pwgen

# Cleanup
RUN apt-get clean

EXPOSE 3306

VOLUME ["/data"]

ENV DATA_DIR /data
RUN mkdir -p $DATA_DIR
RUN sed -i -e 's/^datadir\s*=.*/datadir = \/data/' /etc/mysql/my.cnf
RUN sed -i -e 's/^bind-address/# bind-address/' /etc/mysql/my.cnf

ENV MYSQL_LOG $DATA_DIR/mysql.log

ADD start /start
RUN chmod 0755 /start

CMD ["/start"]

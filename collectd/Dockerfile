FROM alpine:latest

RUN apk --update add collectd py-pip
RUN pip install envtpl

ENV GRAPHITE_SERVER_PORT=2003
ENV GRAPHITE_SERVER_HOST=localhost
ENV GRAPHITE_SERVER_PROTOCOL=tcp

ADD collectd.conf.tpl /etc/collectd/collectd.conf.tpl
RUN envtpl /etc/collectd/collectd.conf.tpl

CMD collectd -f

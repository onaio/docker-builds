FROM ubuntu

MAINTAINER Ukang'a Dickson <ukanga@gmail.com>

RUN apt-get update -qq \
    && apt-get -yqq install python python-dev python-setuptools python-pip python-distribute \
    git libcairo2 libcairo2-dev memcached nginx supervisor libffi-dev
RUN cd /usr/local/src && git clone https://github.com/graphite-project/graphite-web.git
RUN cd /usr/local/src/graphite-web && pip install -r requirements.txt && pip install uwsgi && python setup.py install \
    && apt-get install -yqq libffi-dev && pip install cairocffi
RUN apt-get -yqq install libpq-dev && pip install psycopg2
RUN cd /usr/local/src \
    && git clone https://github.com/graphite-project/whisper.git \
    && cd whisper && python setup.py install
RUN cd /usr/local/src \
    && git clone https://github.com/graphite-project/carbon.git \
    && cd carbon && python setup.py install
ADD graphite/uwsgi.ini /opt/graphite/webapp/uwsgi.ini
ADD graphite/local_settings.py /opt/graphite/webapp/graphite/local_settings.py
ADD graphite/admin_user.py /opt/graphite/webapp/
ADD supervisor/ /etc/supervisor/conf.d
ADD start /start
RUN chmod +x /start
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
    && rm -f /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD graphite/conf/ /opt/graphite/conf/

EXPOSE 8001 2003 2004

CMD ["/start"]

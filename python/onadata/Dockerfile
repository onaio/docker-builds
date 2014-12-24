FROM bradrydzewski/python:2.7

MAINTAINER Ukang'a Dickson <ukanga@ona.io>

RUN sudo apt-get install binutils libproj-dev gdal-bin libmemcached-dev
ADD base.pip /tmp/
RUN . /home/ubuntu/virtualenv/python2.7/bin/activate \
    && pip install numpy pandas==0.12 \
    && pip install -r /tmp/base.pip --allow-all-external

CMD ["python2"]


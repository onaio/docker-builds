FROM ubuntu:14.04
MAINTAINER Dennis Wambua <dwambua@ona.io>
RUN apt-get update
RUN apt-get install -y \
	build-essential \
	debhelper \
	erlang-nox \
	erlang-dev \
	python-matplotlib \
	gnuplot \
	vim \
	libtemplate-perl
RUN apt-get install -y wget \
	git-core \
	awscli
RUN wget http://tsung.erlang-projects.org/dist/debian/tsung_1.5.1-1_all.deb
RUN dpkg -i tsung_1.5.1-1_all.deb

WORKDIR /opt
RUN mkdir /opt/tsung
ADD onadata-small.xml /opt/tsung/
ADD onadata.xml /opt/tsung/
ADD zebra.xml /opt/tsung/
ADD tutorial.json /opt/tsung/
ADD start /opt/tsung/
WORKDIR /opt/tsung
RUN chmod +x /opt/tsung/start
FROM nodesource/trusty:0.10.40
MAINTAINER Dennis Wambua <dwambua@ona.io>
RUN apt-get update
RUN apt-get install -y \
	build-essential \
	libxml2-dev \
	libxslt1-dev \
        git \
        redis-server

RUN npm install -g grunt-cli\ 
                  nodemon\
                  mocha\
                  bower\
                  pm2

WORKDIR /opt
RUN git clone https://github.com/onaio/enketo-express.git --branch tag-1.20.2
WORKDIR /opt/enketo-express

RUN npm install
RUN npm install grunt --save-dev
RUN npm install  time-grunt\
                 load-grunt-tasks\
                 grunt-browserify\
                 grunt-concurrent\
                 grunt-contrib-jshint\
                 grunt-contrib-uglify\
                 grunt-contrib-watch\
                 grunt-env\
                 grunt-jsbeautifier\
                 grunt-karma\
                 grunt-mocha-test\
                 grunt-nodemon\
                 grunt-sass\
                 grunt-shell\
                 aliasify --save-dev
ADD config.json config/config.json
RUN grunt
ADD start /opt/enketo-express/start
RUN chmod +x /opt/enketo-express/start
EXPOSE 8005
CMD ["./start"]

FROM clojure

MAINTAINER Roy Rutto <rrutto@ona.io>

RUN         apt-get update && apt-get install -y redis-server
EXPOSE      6379
ENTRYPOINT  ["/usr/bin/redis-server"]

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash - \
  && apt-get install -y nodejs Xvfb bzip2 \
  &&  npm install -g phantomjs \
  && rm -rf /var/lib/apt/lists/*

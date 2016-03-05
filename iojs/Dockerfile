FROM ubuntu:14.04.2

Maintainer Ukang'a Dickson <ukanga@gmail.com>

RUN apt-get -y update && apt-get install -y curl xz-utils git-core build-essential python && \
    curl https://iojs.org/dist/v2.2.1/iojs-v2.2.1-linux-x64.tar.xz | tar xJ && \
    cp iojs-v2.2.1-linux-x64/bin/iojs /usr/bin/ && \
    cp -r iojs-v2.2.1-linux-x64/lib/node_modules /usr/lib/ && \
    ln -s /usr/bin/iojs /usr/bin/node && \
    ln -s /usr/lib/node_modules/npm/bin/npm-cli.js /usr/bin/npm && \
    npm install -g node-gyp-install && node-gyp-install && \
    groupadd -r ubuntu && useradd -r -g ubuntu ubuntu && \
    apt-get clean

CMD ["iojs"]

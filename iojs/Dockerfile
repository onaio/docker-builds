FROM ubuntu:14.04.2

Maintainer Ukang'a Dickson <ukanga@gmail.com>

RUN apt-get -y update && apt-get install -y curl xz-utils && \
    curl https://iojs.org/dist/v2.2.1/iojs-v2.2.1-linux-x64.tar.xz | tar xJ && \
    cp iojs-v2.2.1-linux-x64/bin/* /usr/bin/ && \
    curl -L https://www.npmjs.com/install.sh | sh && \
    groupadd -r ubuntu && useradd -r -g ubuntu ubuntu && \
    apt-get clean

USER ubuntu

CMD ["iojs"]

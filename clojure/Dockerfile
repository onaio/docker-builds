FROM ubuntu

MAINTAINER Roy Rutto <rrutto@ona.io>

RUN apt-get update -y

RUN apt-get install -y openjdk-7-jdk wget git-core nodejs npm

#Install Leiningen
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN mv lein /usr/bin
RUN chmod 755 /usr/bin/lein
RUN lein version

RUN ln -s `which nodejs` /usr/bin/node
RUN npm install phantomjs

RUN apt-get clean

RUN useradd -m ubuntu
USER ubuntu

CMD ["lein"]

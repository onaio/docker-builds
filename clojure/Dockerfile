FROM ubuntu

MAINTAINER Roy Rutto <rrutto@ona.io>

RUN apt-get update -y
#Install Java
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y wget
#Install Leiningen
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN mv lein /usr/bin
RUN chmod 755 /usr/bin/lein
RUN lein version
RUN apt-get clean

CMD ["lein"]

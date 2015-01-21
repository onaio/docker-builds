FROM bradrydzewski/base
RUN sudo apt-get remove openjdk-6-jdk openjdk-6-jre openjdk-6-jre-headless openjdk-6-jre-lib && \
    sudo apt-get update && sudo apt-get install openjdk-7-jdk openjdk-7-jre

WORKDIR /home/ubuntu
USER ubuntu

RUN wget https://raw.github.com/technomancy/leiningen/stable/bin/lein && \
    sudo install -t /usr/local/bin lein                               && \
    rm lein

FROM bradrydzewski/base
RUN sudo apt-get remove -y default-jre default-jdk openjdk-6-jdk && \
    sudo apt-get update && sudo apt-get install openjdk-7-jdk openjdk-7-jre

WORKDIR /home/ubuntu
USER ubuntu

RUN wget https://raw.github.com/technomancy/leiningen/stable/bin/lein && \
    sudo install -t /usr/local/bin lein                               && \
    rm lein

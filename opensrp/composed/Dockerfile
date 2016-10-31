FROM ubuntu:trusty

MAINTAINER Ephraim Muhia (emuhia@ona.io)


# Installing supervisord
RUN apt-get update && apt-get install -y supervisor

RUN mkdir -p /var/log/supervisor

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Install tomcat
ENV TOMCAT_VERSION 7.0.72

# Install dependencies
RUN apt-get update && \
apt-get install -y  build-essential curl wget software-properties-common vim telnet unzip tar

RUN apt-get update && \
apt-get install -y mysql-client-5.6 && \
rm -rf /var/lib/apt/lists/*

# Get Tomcat
RUN wget --quiet --no-cookies http://apache.rediris.es/tomcat/tomcat-7/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /opt && \
mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
rm /tmp/tomcat.tgz && \
rm -rf /opt/tomcat/webapps/examples && \
rm -rf /opt/tomcat/webapps/docs && \
rm -rf /opt/tomcat/webapps/ROOT

# Download openmrs war and modules
RUN curl -O http://liquidtelecom.dl.sourceforge.net/project/openmrs/releases/OpenMRS_Platform_1.11.5/openmrs.war && \
mv openmrs.war /opt/tomcat/webapps && \
mkdir /root/.OpenMRS && \
curl -O http://netcologne.dl.sourceforge.net/project/keymane/opensrp/opensrp_openmrs_modules.tar.gz && \
tar xzvf opensrp_openmrs_modules.tar.gz  -C /root/.OpenMRS

ENV CATALINA_HOME /opt/tomcat

ENV PATH $PATH:$CATALINA_HOME/bin

VOLUME "/opt/tomcat/webapps"

EXPOSE 8080

# Copying files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY sql ~/sql

COPY sh/*.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/start.sh"]
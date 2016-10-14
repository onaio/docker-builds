# Android Dockerfile

FROM ubuntu:16.04

ARG gradleVersion=2.2
ARG androidComponents=platform-tools,extra-android-support,extra-android-m2repository,extra-google-m2repository
ARG javaPackage=openjdk-8-jdk
ARG androidSdkVersion=24.4.1
ARG buildToolsVersion=21.1.2

MAINTAINER Jason Rogena "jasonrogena@gmail.com"

# General environmental variables
ENV ANDROID_HOME /usr/local/android-sdk

# Sets language to UTF8 : this works in pretty much all cases
ENV LANG en_US.UTF-8
RUN locale-gen $LANG

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive

# Update apt-get
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get dist-upgrade -y

# Installing packages
RUN apt-get install -y \
  autoconf \
  build-essential \
  bzip2 \
  curl \
  gcc \
  git \
  groff \
  lib32stdc++6 \
  lib32z1 \
  lib32z1-dev \
  lib32ncurses5 \
  libc6-dev \
  libgmp-dev \
  libmpc-dev \
  libmpfr-dev \
  libxslt-dev \
  libxml2-dev \
  m4 \
  make \
  ncurses-dev \
  ocaml \
  openssh-client \
  pkg-config \
  python-software-properties \
  rsync \
  software-properties-common \
  unzip \
  wget \
  zip \
  zlib1g-dev \
  --no-install-recommends

# Install Java
RUN apt-add-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get -y install ${javaPackage}

# Clean Up Apt-get
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# Install Android SDK
# Latest SDK link can be obtained from here https://developer.android.com/studio/index.html#Other
RUN wget https://dl.google.com/android/android-sdk_r${androidSdkVersion}-linux.tgz
RUN tar -xvzf android-sdk_r${androidSdkVersion}-linux.tgz
RUN mv android-sdk-linux $ANDROID_HOME
RUN rm android-sdk_r${androidSdkVersion}-linux.tgz

# Install Android tools
# Installe the buildToolsVersion specified as an extra
RUN if ! [ -z "${androidComponents}" ]; then echo y | ${ANDROID_HOME}/tools/android update sdk --filter "${androidComponents},build-tools-${buildToolsVersion}" --no-ui -a; else echo y | ${ANDROID_HOME}/tools/android update sdk --filter "build-tools-${buildToolsVersion}" --no-ui -a; fi

# Environment variables
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$ANDROID_SDK_HOME/build-tools/${buildToolsVersion}

# Install Gradle
WORKDIR /usr/bin

RUN curl -sLO https://services.gradle.org/distributions/gradle-${gradleVersion}-all.zip && \
  unzip gradle-${gradleVersion}-all.zip && \
  ln -s gradle-${gradleVersion} gradle && \
  rm gradle-${gradleVersion}-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Support Gradle
ENV TERM dumb
ENV JAVA_OPTS "-Xms512m -Xmx1024m"
ENV GRADLE_OPTS "-XX:+UseG1GC -XX:MaxGCPauseMillis=1000"

# Cleaning
RUN apt-get clean

# Creating project directories prepared for build when running
# `docker run`
ENV WORKSPACE /workspace
RUN mkdir $WORKSPACE
WORKDIR $WORKSPACE
RUN echo "sdk.dir=$ANDROID_HOME" > local.properties

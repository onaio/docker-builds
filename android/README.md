# Android

This docker build has support for the following Android components and features:

  - platform-tools
  - android-21
  - build-tools-21.1.2
  - extra-android-support
  - extra-android-m2repository
  - extra-google-m2repository

The build uses java-8-openjdk-amd64 and has a bundled Gradle v2.2 daemon

## Running the Dockerfile

Run the following commands to create a Docker image from the Dockerfile and then a container from the image:

  docker build -t onaio_android_image .
  docker run --name onaio_android_container -i -t onaio_android_image

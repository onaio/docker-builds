# Android

This Dockerfile has configurable args:

  - gradleVersion (defaults to 2.2)
  - androidComponents (defaults to platform-tools,extra-android-support,extra-android-m2repository,extra-google-m2repository)
  - javaPackage (defaults to openjdk-8-jdk)
  - androidSdkVersion (defaults to 24.4.1)

## Running the Dockerfile

Run the following commands to create a Docker image from the Dockerfile and then a container from the image:

    docker build -t onaio/android:java8 --build-arg "androidComponents=platform-tools,android-21,build-tools-21.1.2,extra-android-support,extra-android-m2repository,extra-google-m2repository" .
    docker run -i -t onaio/android:java8

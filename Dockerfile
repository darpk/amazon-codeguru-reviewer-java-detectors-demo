FROM gradle:7.3.0-jdk11-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:11

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /home/app.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/home/app.jar"]


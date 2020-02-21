FROM openjdk:8-jdk-alpine

WORKDIR /home/centos

ARG JAR_FILE=/build/libs/*.jar
ADD ${JAR_FILE} app.jar

EXPOSE 8085

ENTRYPOINT ["java","-Dspring.profiles.active=docker","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

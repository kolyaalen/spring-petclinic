FROM openjdk:8-jdk-alpine
WORKDIR /home/centos
RUN ./mvnw package
EXPOSE 8080
CMD [ "java -jar", "target/*.jar" ]

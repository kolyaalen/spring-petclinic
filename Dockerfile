FROM openjdk:8-jdk-alpine
WORKDIR /home/centos
ADD ./ target/
RUN ./mvnw package
EXPOSE 8080
CMD [ "java -jar", "target/*.jar" ]


FROM openjdk:8-jdk-alpine
WORKDIR /home/centos
ADD ./ ./
RUN ./mvnw package
EXPOSE 8080
CMD [ "java -jar", "target/*.jar" ]


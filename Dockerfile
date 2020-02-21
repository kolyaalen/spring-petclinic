FROM openjdk:8-jdk-alpine
WORKDIR /home/centos/
ADD ./target/*jar ./
RUN pwd && ls -la
EXPOSE 8080
CMD [ "java -jar", "*.jar" ]


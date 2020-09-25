FROM java:8-jdk-alpine
COPY ./target/java.client-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/app/
WORKDIR /usr/app
ENTRYPOINT ["java", "-jar", "java.client-1.0-SNAPSHOT-jar-with-dependencies.jar"]
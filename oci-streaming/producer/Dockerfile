FROM java:8-jdk-alpine
COPY ./target/poc-producer-0.0.1-SNAPSHOT-jar-with-dependencies.jar /usr/app/
WORKDIR /usr/app
ENTRYPOINT ["java", "-jar", "poc-producer-0.0.1-SNAPSHOT-jar-with-dependencies.jar"]
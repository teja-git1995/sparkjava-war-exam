FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/myservice-1.0.0.jar myapp.jar
ENTRYPOINT ["java","-jar","myapp.jar"]


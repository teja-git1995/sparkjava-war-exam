FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/hello-microservice-1.0.0.jar myapp.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","myapp.jar"]


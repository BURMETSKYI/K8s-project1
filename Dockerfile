# Build stage
FROM maven:3.9.0-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean package

# Run stage
FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /app

# Copy the JAR from the build stage to the app directory
COPY --from=build /app/target/demoapp-1.0.0.jar /app/

EXPOSE 8080
CMD ["java", "-jar", "/app/demoapp-1.0.0.jar"]

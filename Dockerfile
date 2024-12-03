# Build stage
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests
RUN ls -al /app/target  # Debug to confirm the JAR file exists

# Runtime stage
FROM eclipse-temurin:17.0.6_10-jdk
WORKDIR /apps
COPY --from=build /app/target/demoapp.jar /apps/
EXPOSE 8080
CMD ["java", "-jar", "demoapp.jar"]

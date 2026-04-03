# Stage 1: Build the application
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy only the pom.xml first to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code and build the application
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Create a non-root user for security
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar demo-0.0.1-SNAPSHOT.jar

# Expose the standard Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
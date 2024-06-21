# Use the official maven/Java image to create a build environment
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project source code
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Use a smaller base image for the runtime environment
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build environment to the runtime environment
COPY --from=build /app/target/your-app.jar ./app.jar

# Expose the port your application listens on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]

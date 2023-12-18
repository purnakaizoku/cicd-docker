# Use an official Maven runtime as a parent image
FROM maven:3.8.1-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the project files into the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Use a smaller base image for the final runtime
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the JAR file from the build stage to the runtime image
COPY --from=build /usr/src/app/target/your-application.jar .

# Specify the command to run on container startup
CMD ["java", "-jar", "your-application.jar"]

# Use an openjdk base image
FROM openjdk:8-jre-alpine

# Create a user and group to run the application
RUN addgroup -g 10001 appgroup && adduser -u 10001 -G appgroup -s /bin/sh -D appuser

# Set the working directory
WORKDIR /app

# Download JMusicBot jar file
ADD https://github.com/jagrosh/MusicBot/releases/download/0.4.3/JMusicBot-0.4.3.jar /app/JMusicBot-0.4.3.jar

# Copy serversettings.json from the same directory as the Dockerfile
COPY serversettings.json /app/serversettings.json

# Copy config.txt from the same directory as the Dockerfile
COPY config.txt /app/config.txt 

# Change ownership of the /app directory to the appuser
RUN chown -R appuser:appgroup /app

# Switch to the appuser
USER 10001

# Run the bot
CMD ["java", "-Dnogui=true", "-Dtoken=$TOKEN", "-jar", "/app/JMusicBot-0.4.3.jar"]
 

# Use an openjdk base image
FROM openjdk:8-jre-alpine

# Set the working directory
WORKDIR /app

# Download JMusicBot jar file
ADD https://github.com/jagrosh/MusicBot/releases/download/0.4.3/JMusicBot-0.4.3.jar /app/JMusicBot-0.4.3.jar

# Copy serversettings.json from the same directory as the Dockerfile
COPY serversettings.json /app/serversettings.json

# Run the bot
CMD ["java", "-jar", "/app/JMusicBot-0.4.3.jar"]
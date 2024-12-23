# Use an official OpenJDK slim image for ARM64
FROM openjdk:17-jdk-slim

# Create a user and group to run the application
RUN groupadd -g 10001 appgroup && \
    useradd -r -u 10001 -g appgroup -s /bin/bash appuser

# Set environment variables
ENV TOKEN=""
ENV JAVA_OPTS=""
ARG JMUSICBOT_VERSION=0.4.3

# Set the working directory
WORKDIR /app

# Download JMusicBot jar file
ADD https://github.com/SeVile/MusicBot/releases/download/0.4.3.2/JMusicBot-0.4.3.2.jar /app/JMusicBot.jar

# Copy configuration files into the image
COPY serversettings.json /app/serversettings.json
#COPY config.txt /app/config.txt 

# Change ownership and permissions
RUN chown -R appuser:appgroup /app

# Switch to the appuser
USER 10001

# Run the bot
CMD ["sh", "-c", "java -Dnogui=true $JAVA_OPTS -Dtoken=$TOKEN -jar /app/JMusicBot.jar"]

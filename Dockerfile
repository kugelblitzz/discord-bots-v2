# Use an ARM64-compatible base image with OpenJDK 17
FROM openjdk:17-jre-alpine

# Create a user and group to run the application
RUN addgroup -g 10001 appgroup && adduser -u 10001 -G appgroup -s /bin/sh -D appuser

# Set environment variables
ENV TOKEN=""
ENV JAVA_OPTS=""
ARG JMUSICBOT_VERSION=0.4.3

# Set the working directory
WORKDIR /app

# Download JMusicBot jar file
ADD https://github.com/jagrosh/MusicBot/releases/download/$JMUSICBOT_VERSION/JMusicBot-$JMUSICBOT_VERSION.jar /app/JMusicBot.jar

# Copy configuration files into the image
COPY serversettings.json /app/serversettings.json
COPY config.txt /app/config.txt 

# Change ownership and permissions
RUN chown -R appuser:appgroup /app && chmod -R u+w /app

# Switch to the appuser
USER 10001

# Run the bot
CMD ["sh", "-c", "java -Dnogui=true $JAVA_OPTS -Dtoken=$TOKEN -jar /app/JMusicBot.jar"]

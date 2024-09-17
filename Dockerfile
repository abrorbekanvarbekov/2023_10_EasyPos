FROM amazoncorretto:17-alpine-jdk
ARG JAR_FILE=target/*.war
ARG PROFILES
ARG ENV
COPY ${JAR_FILE} app.war
ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILES}", "-Dserver.env=${ENV}", "-jar", "app.war"]

#FROM bellsoft/liberica-openjdk-alpine:17
#CMD ["./mvnw", "clean", "package"]
#VOLUME /tmp
#ARG JAR_FILE_PATH=*.jar
#COPY ${JAR_FILE_PATH} app.jar
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","/app.jar"]


#docker build -t my-image:v1.0 .
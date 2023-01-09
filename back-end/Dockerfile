FROM openjdk:17-oraclelinux8
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} scrum-master.jar
ENTRYPOINT ["java", "-jar", "/scrum-master.jar"]
EXPOSE 8081

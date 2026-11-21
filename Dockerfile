FROM maven:3.9-eclipse-temurin-8 AS build
WORKDIR /src
COPY pom.xml ./
COPY src/ ./src/
RUN mvn -B -DskipTests package

FROM tomcat:9.0-jdk8-temurin-jammy
COPY --from=build /src/target/smart-office.war /usr/local/tomcat/webapps/smart-office.war

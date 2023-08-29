

FROM maven:3.8.6-amazoncorretto-17 AS MAVEN_BUILD
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/

RUN mvn clean package 

FROM amazoncorretto:17-alpine-jdk

ARG ACTIVE_PROFILE

ENV SPRING_ACTIVE_PROFILE $ACTIVE_PROFILE

WORKDIR /app

COPY --from=MAVEN_BUILD /build/target/HelloWorld.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
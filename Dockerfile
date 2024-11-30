FROM openjdk:17-ea-11-jdk-slim AS BUILDER
RUN mkdir /app_source
COPY . /app_source
WORKDIR /app_source
RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

FROM openjdk:17-ea-11-jdk-slim AS RUNNER
RUN mkdir /app
# 수정된 JAR 복사 경로
COPY --from=BUILDER /app_source/build/libs/*.jar /app
WORKDIR /app
ENV TZ=Asia/Seoul
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/api-0.0.1-SNAPSHOT.jar"]
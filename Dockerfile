FROM openjdk:17-ea-11-jdk-slim AS BUILDER
RUN mkdir /app_source
COPY .. /app_source
WORKDIR /app_source
RUN chmod +x ./gradlew
# clean build 실행, 테스트 제외
RUN ./gradlew clean build -x test

FROM openjdk:17-ea-11-jdk-slim AS RUNNER
RUN mkdir /app
# 빌드 결과 JAR 파일 복사
COPY --from=BUILDER /app_source/api/build/libs /app
WORKDIR /app
ENV TZ=Asia/Seoul
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/api-0.0.1-SNAPSHOT.jar"]

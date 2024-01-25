FROM  acrnoaman.azurecr.io/openjdk:17.0-jdk
ENV TZ=Asia/Calcutta
RUN mkdir /APP
WORKDIR /APP
COPY target/spring-boot-app-1.4.0.RELEASE.jar  /APP/app-service.jar
EXPOSE 8080
RUN chmod -R 777 /APP/*
ENTRYPOINT ["java","-jar","/APP/app-service.jar"]

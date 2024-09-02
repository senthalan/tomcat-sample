FROM maven:3.8.5-openjdk-17-slim

WORKDIR /tomcat-sample
COPY . /tomcat-sample

RUN mvn clean install

FROM tomcat:jre17

WORKDIR /tomcat-sample

COPY --from=0 /tomcat-sample/target/my-webapp /usr/local/tomcat/webapps/my-webapp/
COPY --from=0 /tomcat-sample/logging.properties /usr/local/tomcat/conf/logging.properties

RUN ls -la /usr/local/tomcat/webapps/

RUN mkdir -p /usr/local/tomcat/conf/Catalina/localhost #Hardcoding this privilege will obviously solve the problem

EXPOSE 8080

USER 10014

CMD ["catalina.sh", "run"]

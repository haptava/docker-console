# Version: 0.0.1
FROM dockerfile/java:oracle-java8
MAINTAINER Paul Ambrose "pambrose@mac.com"

RUN apt-get update
RUN apt-get -y install maven
RUN apt-get clean

COPY ./pom.xml /haptava/
COPY ./log4j/ /haptava/log4j/

RUN cd /haptava && mvn clean package

ADD http://downloads.haptava.io/releases/0.9.39/lib/haptava-console.war /haptava/lib/

WORKDIR /haptava

EXPOSE 8080

ENV HAPTAVA_HOME /haptava

ENTRYPOINT ["/haptava/target/bin/warserver.sh", \
            "--port", "8080", \
            "--war", "/haptava/lib/haptava-console.war", \
	        "-Dhaptava.securecookies.enabled=false"]

# docker run -it --rm -p 8080:8080 haptava/console:0.9.39

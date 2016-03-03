# Version: 0.0.1
FROM java:8
MAINTAINER Paul Ambrose "pambrose@mac.com"

RUN apt-get update
RUN apt-get -y install maven
RUN apt-get clean

VOLUME ["/haptava/conf"]

COPY ./pom.xml /haptava/
COPY ./conf/ /haptava/conf/
ADD http://downloads.haptava.io/releases/0.9.39/lib/haptava-console.war /haptava/war/

RUN cd /haptava && mvn clean package && mv target/bin target/lib .

WORKDIR /haptava

# 8080 for console access, 8090 for admin servlets
EXPOSE 8080 8090

ENV HAPTAVA_HOME /haptava

ENTRYPOINT ["/haptava/bin/warserver.sh", \
            "--port", "8080", \
            "--war", "/haptava/war/haptava-console.war", \
	        "-Dhaptava.securecookies.enabled=false"]

# docker run -it --rm -p 8080:8080 haptava/console:0.9.39 -u fred -p topsecret -ln docker-console

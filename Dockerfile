# Version: 0.0.1
FROM dockerfile/java:oracle-java8
MAINTAINER Paul Ambrose "pambrose@mac.com"

COPY log4j/ /haptava/log4j/
COPY target/bin /haptava/bin/
COPY target/repo /haptava/repo/
ADD http://downloads.haptava.io/releases/0.9.39/lib/haptava-console.war /haptava/lib/

EXPOSE 8080

WORKDIR /haptava

ENV HAPTAVA_HOME /haptava

ENTRYPOINT ["/haptava/bin/docker-warserver.sh", \
            "--port", "8080", \
            "--war", "/haptava/lib/haptava-console.war", \
	        "-Dhaptava.securecookies.enabled=false"]

# docker run -it --entrypoint=/bin/bash haptava/console:0.9.39
# docker run -it  -p 8080:8080 haptava/console:0.9.39

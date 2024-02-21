FROM ubuntu

ENV TRACCAR_VERSION 4.14

WORKDIR /opt/traccar

RUN apt-get update -y && apt-get upgrade -y 
RUN apt-get install wget unzip openjdk-17-jdk -y 

RUN wget -O /tmp/traccar.zip --no-check-certificate https://github.com/traccar/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip
RUN unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip 


# COPY conf/traccar.xml /opt/traccar/conf/

ENTRYPOINT ["java", "-Xms512m", "-Xmx512m", "-Djava.net.preferIPv4Stack=true"]

CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]


# traccar-for-k8s

update conf/traccar.xml with your mysql database access

creating a configmap for the traccar.xml and default.yml

k create configmap traccar --from-file conf/traccar.xml  --from-file conf/default.xml

k apply -f traccar.yml 

k apply -f traccar_service.yml

k apply -f traccar_client_service.yml

k apply -f traccar_ingress.yml




cat Dockerfile

FROM ubuntu

ENV TRACCAR_VERSION 4.14

WORKDIR /opt/traccar

RUN apt-get update -y && \
    apt-get install openjdk-17-jdk -y && \
    apt-get install wget -y && \
    apt-get install unzip -y && \
    wget -O /tmp/traccar.zip --no-check-certificate https://github.com/traccar/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip

COPY traccar.xml /opt/traccar/conf/

ENTRYPOINT ["java", "-Xms512m", "-Xmx512m", "-Djava.net.preferIPv4Stack=true"]

CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]




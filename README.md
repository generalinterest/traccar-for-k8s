# traccar-for-k8s


creating a configmap for the traccar.xml and default.yml to keep our database credentials obscure.

k create configmap traccar-xml --from-file conf/traccar.xml
k create configmap default-xml --from-file conf/default.xml
 k get configmap traccar-xml -o yaml > part1.yml
 k get configmap default-xml -o yaml > part2.yml

combing part1 and part to create a well formed traccar_configmap.yml

 k apply -f traccar_configmap.yml


k apply -f traccar.yml 

k apply -f traccar_service.yml
k apply -f traccar_client_service.yml

k apply -f traccar_ingress.yml




cat Dockerfile
FROM openjdk:8-jre-alpine

ENV TRACCAR_VERSION 4.6

WORKDIR /opt/traccar

RUN set -ex && \
    apk add --no-cache --no-progress wget && \
    wget -qO /tmp/traccar.zip https://github.com/traccar/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip && \
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    apk del wget
COPY traccar.xml /opt/traccar/conf/

ENTRYPOINT ["java", "-Xms512m", "-Xmx512m", "-Djava.net.preferIPv4Stack=true"]

CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]




# traccar-for-k8s

No need to build my own multi-arch docker image anymore as hub.docker.com has traccar/traccar:ubuntu multi-arch image now.

Will use a Database for persistence...

Create the traccar myssql/mariadb database on your database server, change the password to something less obvious...

create database traccar 
create user 'traccar'@'%' identified by 'traccar';
grant all privileges on traccar.* to 'traccar'@'%';
flush privileges;

You need to retrieve the conf/default.xml and conf/traccar.xml, either from their github repo, or you might start the docker image, and pull them from it.

https://github.com/traccar/traccar/blob/master/setup/default.xml
https://github.com/traccar/traccar/blob/master/setup/traccar.xml


update conf/traccar.xml with your mysql database access

    <entry key='database.driver'>com.mysql.cj.jdbc.Driver</entry>
    <entry key='database.url'>jdbc:mysql://{mysqlHost}3306/traccar?allowMultiQueries=true&amp;autoReconnect=true&amp;useUnicode=yes&amp;characterEncoding=latin1&amp;sessionVariables=sql_mode=ANSI_QUOTES</entry>
    <entry key='database.user'>traccar</entry>
    <entry key='database.password'>traccar</entry>


Note that the default.yml specifies the http listen port 8082.

creating a configmap for the traccar.xml and default.yml

k create configmap traccar --from-file conf/traccar.xml  --from-file conf/default.xml

k apply -f traccar.yml 

k apply -f traccar_service.yml

k apply -f traccar_ingress.yml


For the traccar clients to send their location data to traccar, there are many ports preconfigured.  Just open one for now

k apply -f traccar_client_service.yml

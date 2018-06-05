FROM tomcat:7-jre8
RUN wget -qO GPG-KEY-elasticsearch.asc https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN apt-get update && apt-key add GPG-KEY-elasticsearch.asc
RUN apt-get install -y apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" >> /etc/apt/sources.list.d/elastic-6.x.list
RUN apt-get update && apt-get install -y filebeat metricbeat packetbeat
COPY metricbeat.yml /usr/share/metricbeat/
COPY filebeat.yml /usr/share/filebeat/
RUN update-rc.d filebeat defaults 95 10
RUN update-rc.d metricbeat defaults 95 10
RUN update-rc.d packetbeat defaults 95 10
RUN apt-get install -y wget
RUN apt-get install -y vim
COPY tomcat-users.xml /usr/local/tomcat/conf/
RUN wget -O /usr/local/tomcat/webapps/spring-petclinic.war http://34.196.120.121:8081/nexus/service/local/artifact/maven/redirect?r=snapshots\&g=org.springframework.samples\&a=spring-petclinic\&v=1.0-SNAPSHOT\&p=war

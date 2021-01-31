FROM jboss/wildfly:21.0.2.Final
LABEL maintainer=danielme_com@yahoo.com

USER root
RUN yum -y install git
USER jboss

RUN git clone -q https://github.com/danielme-com/hello-docker-war.git \
    && cd hello-docker-war \
    && ./mvnw package \
    && mv target/hello-docker.war $JBOSS_HOME/standalone/deployments \
    && cd .. \
    && rm -rf hello-docker-war	

EXPOSE 8080

COPY standalone.xml $JBOSS_HOME/standalone/configuration

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]


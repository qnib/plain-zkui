FROM qnib/alplain-jdk8

ARG MAVEN_VERSION="3.3.9"
ENV ENTRYPOINTS_DIR=/opt/qnib/entry \
    M2_HOME=/usr/lib/mvn \
    JAVA_HOME=/usr/lib/jvm/java-8-oracle/ \
    ZKUI_PORT=9090 \
    ZK_SERVER=zk_backend:2181 \
    ZKUI_ADMIN_PW=manager

RUN apk --no-cache add wget curl \
 && wget -qO - "http://ftp.unicamp.br/pub/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar xfz - -C /opt/ \
 && mv "/opt/apache-maven-$MAVEN_VERSION" "$M2_HOME" \
 && ln -s "$M2_HOME/bin/mvn" /usr/bin/mvn \
 && wget -qO /tmp/master.zip https://github.com/DeemOpen/zkui/archive/master.zip \
 && cd /opt/ \
 && unzip /tmp/master.zip \
 && mv /opt/zkui-master /opt/zkui \
 && apk --no-cache del wget \
 && cd /opt/zkui && mvn clean install \
 && rm -rf /tmp/* /var/cache/apk/* /usr/lib/mvn /opt/zkui/config.cfg
RUN echo "grep zkSer /opt/zkui/config.cfg" >> /root/.bash_history
ENV ZKUI_ADMIN_PW=admin \
    ZKUI_USER_PW=user \
    ZKUI_PORT=9090
COPY opt/qnib/zkui/bin/start.sh /opt/qnib/zkui/bin/
COPY opt/qnib/entry/* /opt/qnib/entry/
COPY opt/qnib/zkui/conf/zkui.conf.orig /opt/qnib/zkui/conf/
HEALTHCHECK --interval=2s --retries=300 --timeout=1s \
  CMD curl sI http://localhost:${ZKUI_PORT}
CMD ["/opt/qnib/zkui/bin/start.sh"]

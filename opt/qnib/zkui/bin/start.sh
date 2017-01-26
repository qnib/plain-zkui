#!/bin/bash

cd /opt/zkui/
cat /opt/qnib/zkui/conf/zkui.conf.orig | sed -e "s/ZKUI_PORT/${ZKUI_PORT}/" -e "s/ZK_SERVER/${ZK_SERVER}/" -e "s/ZKUI_ADMIN_PW/${ZKUI_ADMIN_PW}/" > /opt/zkui/zkui.conf
java -jar /opt/zkui/target/zkui-2.0-SNAPSHOT-jar-with-dependencies.jar

#!/bin/bash

set -e

TOMCAT_HOME=/opt/tomcat/apache-tomcat-9.0.117
WAR_NAME=portal

echo "======================================"
echo " Deploying..."
echo "======================================"
sudo docker compose exec app mvn package \
  -f /workspace/pom.xml

echo ""
echo "======================================"
echo " Delete before deploy..."
echo "======================================"
sudo docker compose exec app rm -rf \
  $TOMCAT_HOME/webapps/$WAR_NAME.war \
  $TOMCAT_HOME/webapps/$WAR_NAME

echo ""
echo "======================================"
echo " Deploy new war..."
echo "======================================"
sudo docker compose exec app cp \
  /workspace/target/$WAR_NAME.war \
  $TOMCAT_HOME/webapps/$WAR_NAME.war

echo ""
echo "======================================"
echo " Tomcat logs..."
echo "======================================"
sleep 3
sudo docker compose exec app cat \
  $TOMCAT_HOME/logs/localhost.$(date +%Y-%m-%d).log
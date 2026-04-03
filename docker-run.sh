#!/bin/bash

set -e

TOMCAT_HOME=/opt/tomcat/apache-tomcat-9.0.117
WAR_NAME=portal

echo "======================================"
echo " 🚀 Compilando proyecto..."
echo "======================================"
sudo docker compose exec app mvn package \
  -f /workspace/pom.xml

echo ""
echo "======================================"
echo " 🗑️  Eliminando despliegue anterior..."
echo "======================================"
sudo docker compose exec app rm -rf \
  $TOMCAT_HOME/webapps/$WAR_NAME.war \
  $TOMCAT_HOME/webapps/$WAR_NAME

echo ""
echo "======================================"
echo " 📦 Desplegando nuevo .war..."
echo "======================================"
sudo docker compose exec app cp \
  /workspace/target/$WAR_NAME.war \
  $TOMCAT_HOME/webapps/$WAR_NAME.war

echo ""
echo "======================================"
echo " 📋 Logs de Tomcat..."
echo "======================================"
sleep 3
sudo docker compose exec app cat \
  $TOMCAT_HOME/logs/localhost.$(date +%Y-%m-%d).log
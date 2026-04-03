FROM debian:bullseye-slim

# ── Variables de versión (ajusta a tus nombres reales) ──────────────────
ARG JDK_TAR=jdk-8u202-linux-x64.tar.gz
ARG MAVEN_TAR=apache-maven-3.9.14-bin.tar.gz
ARG TOMCAT_TAR=apache-tomcat-9.0.117.tar.gz

# ── Dependencias mínimas del sistema ────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# ── Copiar tarballs desde tu máquina ────────────────────────────────────
COPY tarballs/$JDK_TAR    /tmp/
COPY tarballs/$MAVEN_TAR  /tmp/
COPY tarballs/$TOMCAT_TAR /tmp/

# ── Instalar JDK 1.7 ────────────────────────────────────────────────────
RUN mkdir -p /opt/java && \
    tar -xzf /tmp/$JDK_TAR -C /opt/java && \
    rm /tmp/$JDK_TAR

# ── Instalar Maven ───────────────────────────────────────────────────────
RUN mkdir -p /opt/maven && \
    tar -xzf /tmp/$MAVEN_TAR -C /opt/maven && \
    rm /tmp/$MAVEN_TAR

# ── Instalar Tomcat 7 ────────────────────────────────────────────────────
RUN mkdir -p /opt/tomcat && \
    tar -xzf /tmp/$TOMCAT_TAR -C /opt/tomcat && \
    rm /tmp/$TOMCAT_TAR

# ── Variables de entorno ─────────────────────────────────────────────────
ENV JAVA_HOME=/opt/java/jdk1.8.0_202
ENV MAVEN_HOME=/opt/maven/apache-maven-3.9.14
ENV CATALINA_HOME=/opt/tomcat/apache-tomcat-9.0.117
ENV PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$CATALINA_HOME/bin:$PATH

# ── Puerto de Tomcat ──────────────────────────────────────────────────────
EXPOSE 8080

# ── Arrancar Tomcat ───────────────────────────────────────────────────────
CMD ["catalina.sh", "run"]
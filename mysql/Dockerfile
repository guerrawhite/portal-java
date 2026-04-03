FROM debian:bullseye-slim

ARG MYSQL_TAR=mysql-5.7.44-linux-glibc2.12-x86_64.tar.gz

# ── Dependencias necesarias para MySQL binario ────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    libaio1 \
    libncurses5 \
    numactl \
    && rm -rf /var/lib/apt/lists/*

# ── Copiar e instalar MySQL ───────────────────────────────────────────────
COPY tarballs/$MYSQL_TAR /tmp/
RUN mkdir -p /opt/mysql && \
    tar -xzf /tmp/$MYSQL_TAR -C /opt/mysql && \
    rm /tmp/$MYSQL_TAR

# ── Usuario y directorios de datos ───────────────────────────────────────
RUN groupadd -r mysql && useradd -r -g mysql mysql && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld /opt/mysql

ENV MYSQL_HOME=/opt/mysql/mysql-5.7.44-linux-glibc2.12-x86_64
ENV PATH=$MYSQL_HOME/bin:$PATH

# ── Variables de base de datos (sobreescribibles desde docker-compose) ────
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=portaldb
ENV MYSQL_USER=portaluser
ENV MYSQL_PASSWORD=portalpass

# ── Script de arranque ────────────────────────────────────────────────────
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
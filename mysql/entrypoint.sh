#!/bin/bash
set -e

MYSQL_DIR=/opt/mysql/mysql-5.7.44-linux-glibc2.12-x86_64
DATA_DIR=/var/lib/mysql

if [ ! -d "$DATA_DIR/mysql" ]; then
    echo ">>> Inicializando MySQL por primera vez..."
    $MYSQL_DIR/bin/mysqld \
        --initialize-insecure \
        --user=mysql \
        --datadir=$DATA_DIR \
        --basedir=$MYSQL_DIR

    # Arrancar temporalmente para configurar usuarios
    echo ">>> Arrancando MySQL temporal para configuración..."
    $MYSQL_DIR/bin/mysqld \
        --user=mysql \
        --datadir=$DATA_DIR \
        --basedir=$MYSQL_DIR \
        --skip-networking &

    MYSQL_PID=$!

    # Esperar a que arranque
    echo ">>> Esperando a MySQL..."
    until $MYSQL_DIR/bin/mysqladmin ping --silent 2>/dev/null; do
        sleep 1
    done

    echo ">>> Configurando usuarios y base de datos..."
    $MYSQL_DIR/bin/mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    echo ">>> Deteniendo MySQL temporal..."
    kill $MYSQL_PID
    wait $MYSQL_PID 2>/dev/null || true
fi

echo ">>> Arrancando MySQL..."
exec $MYSQL_DIR/bin/mysqld \
    --user=mysql \
    --datadir=$DATA_DIR \
    --basedir=$MYSQL_DIR \
    --bind-address=0.0.0.0 \
    --port=3306
echo "CREATE USER '${ENV_MARIADB_USERNAME}'@'localhost' IDENTIFIED BY '${ENV_MARIADB_PASSWORD}';" > /home_podman/mariadb/init.sql

echo "GRANT ALL PRIVILEGES ON *.* TO '${ENV_MARIADB_USERNAME}'@'localhost' WITH GRANT OPTION;" >> /home_podman/mariadb/init.sql

echo "ALTER USER '${ENV_MARIADB_USERNAME}'@'%' IDENTIFIED BY '${ENV_MARIADB_PASSWORD}';" >> /home_podman/mariadb/init.sql

echo "GRANT ALL PRIVILEGES ON *.* TO '${ENV_MARIADB_USERNAME}'@'%' WITH GRANT OPTION;" >> /home_podman/mariadb/init.sql

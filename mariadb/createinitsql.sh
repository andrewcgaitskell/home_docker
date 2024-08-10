echo "CREATE USER '${MARIADB_USERNAME}'@'localhost' IDENTIFIED BY '${MARIADB_PASSWORD}';" > /home_podman/mariadb/init.sql

echo "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USERNAME}'@'localhost' WITH GRANT OPTION;" >> /home_podman/mariadb/init.sql

echo "ALTER USER '${MARIADB_USERNAME}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';" >> /home_podman/mariadb/init.sql

echo "GRANT ALL PRIVILEGES ON *.* TO '${MARIADB_USERNAME}'@'%' WITH GRANT OPTION;" >> /home_podman/mariadb/init.sql

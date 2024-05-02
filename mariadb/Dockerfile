FROM mariadb:10.11

RUN apt-get update
RUN apt-get update
RUN apt-get -y install unzip

## this is just some test data
COPY world-db.zip /var/www/html/world-db.zip
RUN unzip -j /var/www/html/world-db.zip -d /docker-entrypoint-initdb.d

COPY init.sql /docker-entrypoint-initdb.d/init.sql

env MARIADB_USER=pythonuser
env MARIADB_PASSWORD=pythonuser
env MARIADB_ROOT_PASSWORD=pythonuser
env MARIADB_DATABASE=data

EXPOSE 3306

CMD ["mysqld"]

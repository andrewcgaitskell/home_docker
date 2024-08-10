## set environmental variables

# remember to copy the .env file into create before running this

cp ./.env ../mariadb/.env
cp ./.env ../fastapi_data/app/.env
cp ./.env ../fastapi_about/app/.env
cp ./.env ../application/app/.env
cp ./.env ../application/app/baseapp/.env
cp ./.env ../backup_db/.env

## set the variables for the mariadb container
source ../mariadb/setenv.sh
source ../mariadb/createinitsql.sh
source ../backup_db/createinitsql.sh

## redis image

cd /opt/dmtools/code/dmtools/basecode/redis
podman stop container_redis_1
podman rm container_redis_1
podman rmi redis_1

podman build -f Dockerfile -t redis_1 .

#podman pull docker.io/dmto0l2022/redis_1:latest

## mariadb image

cd /opt/dmtools/code/dmtools/basecode/mariadb

rm -rf /data/containers/data/mysql
mkdir /data/containers/data/mysql

rm /opt/dmtools/code/dmtools/basecode/mariadb/x_20211104_dmtools_backup.sql

## added x to name so it is executed after init.sql

cp /data/containers/data/original_data/20211104_dmtools_backup.sql /opt/dmtools/code/dmtools/basecode/mariadb/x_20211104_dmtools_backup.sql

podman stop container_mariadb
podman rm container_mariadb
podman rmi mariadb_1

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
--build-arg=BUILD_ENV_MARIADB_USER=${ENV_MARIADB_USER} \
--build-arg=BUILD_ENV_MARIADB_PASSWORD=${ENV_MARIADB_PASSWORD} \
--build-arg=BUILD_ENV_MARIADB_ROOT_PASSWORD=${ENV_MARIADB_ROOT_PASSWORD} \
--build-arg=BUILD_ENV_MARIADB_DATABASE=${ENV_MARIADB_DATABASE} \
-t mariadb_1 .

##-v /HOST-DIR:/CONTAINER-DIR

## DastAPI Data Image

cd /opt/dmtools/code/dmtools/basecode/fastapi_data

rm -rf /opt/dmtools/code/dmtools/basecode/fastapi_data/app/migrations/

podman stop container_fastapi_data_1
podman rm container_fastapi_data_1

podman rmi fastapi_data_1

## --build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t fastapi_data_1


rm -rf /opt/dmtools/code/dmtools/basecode/fastapi_about/app/migrations/

## FastAPI About Image

cd /opt/dmtools/code/dmtools/basecode/fastapi_about

podman stop container_fastapi_about_1
podman rm container_fastapi_about_1

podman rmi fastapi_about_1

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t fastapi_about_1

## application image

cd /opt/dmtools/code/dmtools/basecode/application

podman stop container_application_1
podman rm container_application_1

podman rmi application_1:latest

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t application_1 .

## set environmental variables

# remember to copy the .env file into create before running this

cp ./.env ../mariadb/.env
##cp ./.env ../fastapi_data/app/.env
##cp ./.env ../fastapi_about/app/.env
##cp ./.env ../application/app/.env
##cp ./.env ../application/app/baseapp/.env
##cp ./.env ../backup_db/.env

## set the variables for the mariadb container
source setenv.sh
source ./mariadb/createinitsql.sh

## mariadb image

cd /home_podman/mariadb

rm -rf /home_data/mariadb
mkdir /home_data/mariadb

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

cd /home_podman/jupyter_2

rm -rf /opt/dmtools/code/dmtools/basecode/fastapi_data/app/migrations/

podman stop container_jupyter_2
podman rm container_jupyter_2

podman rmi image_jupyter_2

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t image_jupyter_2


cd /home_podman/reactjs

podman stop container_reactjs
podman rm container_reactjs

podman rmi image_reactjs

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t image_reactjs

## application image

cd /home_podman/mosquitto

podman stop container_mosquitto
podman rm container_mosquitto

podman rmi image_mosquitto:latest

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
-f Dockerfile -t image_mosquitto .

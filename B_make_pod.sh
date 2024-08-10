## set environment variables

source setenv.sh

podman stop container_redis_1
podman rm container_redis_1

podman volume rm redis-data

podman stop container_mariadb
podman rm container_mariadb

podman stop container_fastapi_data_1
podman rm container_fastapi_data_1

podman stop container_fastapi_about_1
podman rm container_fastapi_about_1

podman stop container_application_1
podman rm container_application_1

podman pod stop pod_main_backend
podman pod rm pod_main_backend

uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))


podman pod create \
--name pod_main_backend \
--infra-name infra_main_backend \
--network bridge \
--uidmap 0:1:$uid \
--uidmap $uid:0:1 \
--uidmap $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
--gidmap 0:1:$gid \
--gidmap $gid:0:1 \
--gidmap $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
--publish 8010:8010 \
--publish 8014:8014 \
--publish 8016:8016 \
--publish 3306:3306 \
--publish 6379

podman volume create redis-data

podman create \
--name container_redis_1 \
--pod pod_main_backend \
--user $uid:$gid \
--volume redis-data:/data \
localhost/redis_1:latest

rm -rf /data/containers/data/mysql
mkdir /data/containers/data/mysql

podman create \
--name container_mariadb \
--pod pod_main_backend \
--user $uid:$gid \
--log-opt max-size=10mb \
--volume /data/containers/data/mysql:/var/lib/mysql:z \
--volume /data/containers/data/backups:/data/backups:z \
localhost/mariadb_1:latest

rm -rf /opt/dmtools/code/dmtools/basecode/fastapi_data/app/migrations/
rm -rf /opt/dmtools/code/dmtools/basecode/fastapi_about/app/migrations/

podman create \
--name container_fastapi_data_1 \
--pod pod_main_backend \
--user $uid:$gid \
--log-opt max-size=10mb \
-v /opt/dmtools/code/dmtools/basecode:/workdir:Z \
localhost/fastapi_data_1:latest

podman create \
--name container_fastapi_about_1 \
--pod pod_main_backend \
--user $uid:$gid \
--log-opt max-size=10mb \
-v /opt/dmtools/code/dmtools/basecode:/workdir:Z \
localhost/fastapi_about_1:latest

podman create \
--name container_application_1 \
--pod pod_main_backend \
--user $uid:$gid \
--log-opt max-size=10mb \
-v /opt/dmtools/code/dmtools/basecode:/workdir:Z \
localhost/application_1:latest

podman start infra_main_backend
podman start container_mariadb
podman start container_redis_1
podman start container_fastapi_about_1
podman start container_fastapi_data_1

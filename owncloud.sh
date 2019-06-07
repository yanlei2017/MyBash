docker volume create owncloud_redis

docker run -d \
  --name redis \
  -e REDIS_DATABASES=1 \
  --volume owncloud_redis:/var/lib/redis \
  webhippie/redis:latest
#########################################################
docker volume create owncloud_mysql
docker volume create owncloud_backup

docker run -d \
  --name mariadb \
  -e MARIADB_ROOT_PASSWORD=yanlei_2019 \
  -e MARIADB_USERNAME=owncloud \
  -e MARIADB_PASSWORD=yanlei_2019 \
  -e MARIADB_DATABASE=owncloud \
  --volume owncloud_mysql:/var/lib/mysql \
  --volume owncloud_backup:/var/lib/backup \
  webhippie/mariadb:latest

#########################################################

export OWNCLOUD_VERSION=10.0
export OWNCLOUD_DOMAIN=localhost
export ADMIN_USERNAME=admin	
export ADMIN_PASSWORD=yanlei_2019

docker volume create owncloud_files

docker run -d \
  --name owncloud \
  --link mariadb:db \
  --link redis:redis \
  -e OWNCLOUD_DOMAIN=${OWNCLOUD_DOMAIN} \
  -e OWNCLOUD_DB_TYPE=mysql \
  -e OWNCLOUD_DB_NAME=owncloud \
  -e OWNCLOUD_DB_USERNAME=owncloud \
  -e OWNCLOUD_DB_PASSWORD=yanlei_2019 \
  -e OWNCLOUD_DB_HOST=db \
  -e OWNCLOUD_ADMIN_USERNAME=${ADMIN_USERNAME} \
  -e OWNCLOUD_ADMIN_PASSWORD=${ADMIN_PASSWORD} \
  -e OWNCLOUD_REDIS_ENABLED=true \
  -e OWNCLOUD_REDIS_HOST=redis \
  --volume owncloud_files:/mnt/data \
  -p 80:8080 \
  owncloud/server:${OWNCLOUD_VERSION}

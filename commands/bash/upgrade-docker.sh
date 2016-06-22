docker pull
docker stop $DOCKER_IMAGE
docker rm $DOCKER_IMAGE
docker run --name=$DOCKER_IMAGE --restart=always \
  $ARGS

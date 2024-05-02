sudo docker compose up -d --build
sudo docker logs reactjs_container


npm init react-app reactjs


Unix

To delete all containers including its volumes use,

docker rm -vf $(docker ps -aq)
To delete all the images,

docker rmi -f $(docker images -aq)



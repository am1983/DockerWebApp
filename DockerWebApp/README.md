docker build . -t netcore-angular-docker

docker run -d -p 8090:80 netcore-angular-docker
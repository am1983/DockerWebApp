docker build . -t netcore-angular-docker

docker run -d -p 8090:80 netcore-angular-docker

Changes have been made to the Dockerfile to support Raspberry Pi ARM chips.

Using mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim-arm32v7 instead of
mcr.microsoft.com/dotnet/core/aspnet:3.1

Build instructions have been changed from:
FROM build as publish
RUN dotnet publish "DockerWebApp.csproj" -c Release -o /app/publish

To:
FROM build as publish
RUN dotnet publish "DockerWebApp.csproj" -c Release -o /app/publish -r linux-arm

This can be pushed out to a Docker Swarm using the command:

docker service create --name netcore-webapp -p 80:80 --replicas # amdev83/netcore-angular-docker-arm32v7




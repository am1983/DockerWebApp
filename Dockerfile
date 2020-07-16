FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim-arm32v7 AS base
RUN apt-get update -yq \
    && apt-get install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && apt-get install nodejs -yq
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.1.300 AS build
RUN apt-get update -yq \
    && apt-get install curl gnupg -yq \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && apt-get install nodejs -yq
WORKDIR /src
COPY ["DockerWebApp/DockerWebApp.csproj", "DockerWebApp/"]
RUN dotnet restore "DockerWebApp/DockerWebApp.csproj"
COPY . .
WORKDIR "/src/DockerWebApp"
RUN dotnet build "DockerWebApp.csproj" -c Release -o /app/build

FROM build as publish
RUN dotnet publish "DockerWebApp.csproj" -c Release -o /app/publish -r linux-arm

FROM base as final
WORKDIR /app 
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DockerWebApp.dll"]

FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /api
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /appbuild

COPY . .
RUN dotnet restore
WORKDIR /appbuild/Lab01_API
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /api
COPY --from=build /appbuild/Lab01_API/out .
ENTRYPOINT ["dotnet", "Lab01_API.dll"]
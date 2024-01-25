FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ./Api .
RUN dotnet restore

WORKDIR /app/api
RUN dotnet publish -c release -o /out --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app/api
COPY --from=build /out .
ENTRYPOINT ["dotnet", "Api.dll"]

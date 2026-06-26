# Build context is the api/ directory:  docker build -f api/Dockerfile api
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Restore against just the project file first for better layer caching.
COPY Directory.Build.props ./
COPY src/ABIS.Api/ABIS.Api.csproj src/ABIS.Api/
RUN dotnet restore src/ABIS.Api/ABIS.Api.csproj

# Then bring in the source and publish.
COPY src/ ./src/
RUN dotnet publish src/ABIS.Api/ABIS.Api.csproj -c Release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
# curl: lets the container expose a HEALTHCHECK against the readiness probe.
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /app ./

# Kestrel listens on 8080 inside the container.
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --retries=5 --start-period=20s \
    CMD curl -fsS http://localhost:8080/health/ready || exit 1
ENV ASPNETCORE_URLS=http://+:8080 \
    ASPNETCORE_ENVIRONMENT=Production
ENTRYPOINT ["dotnet", "ABIS.Api.dll"]

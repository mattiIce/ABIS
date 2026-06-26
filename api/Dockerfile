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
# curl: HEALTHCHECK against the readiness probe.
# tzdata: gives .NET a real timezone database, so the ODP.NET session time zone
#   is a region Oracle 11g recognizes (the slim image otherwise has none, which
#   surfaces as ORA-01882 'timezone region not found' on connect).
RUN apt-get update && apt-get install -y --no-install-recommends curl tzdata \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /app ./

# Kestrel listens on 8080 inside the container.
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --retries=5 --start-period=20s \
    CMD curl -fsS http://localhost:8080/health/ready || exit 1
# TZ sets the container's timezone to a region Oracle 11g knows (the plant runs
# US Eastern), which the ODP.NET session adopts — avoiding ORA-01882. Override
# via the TZ env (compose passes ${ABIS_TZ}) for a different site.
ENV ASPNETCORE_URLS=http://+:8080 \
    ASPNETCORE_ENVIRONMENT=Production \
    TZ=America/New_York
ENTRYPOINT ["dotnet", "ABIS.Api.dll"]

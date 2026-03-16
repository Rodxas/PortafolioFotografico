# Zuzu Hernández - Portafolio de Fotografía de Modas
# Dockerfile para despliegue en contenedores

# ============================================
# Stage 1: Build
# ============================================
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build

# Establecer directorio de trabajo
WORKDIR /src

# Copiar archivos de proyecto
COPY ZuzuPortfolio.csproj ./
COPY Program.cs ./
COPY appsettings.json ./
COPY appsettings.Development.json ./

# Restaurar dependencias
RUN dotnet restore

# Copiar todos los archivos
COPY . .

# Publicar en modo Release
RUN dotnet publish -c Release -o /src/publish

# ============================================
# Stage 2: Runtime
# ============================================
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime

# Establecer directorio de trabajo
WORKDIR /src

# Copiar archivos publicados
COPY --from=build /src/publish .

# Exponer puerto
EXPOSE 8080
EXPOSE 443

# Configurar URL
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

# Iniciar aplicación
ENTRYPOINT ["dotnet", "ZuzuPortfolio.dll"]

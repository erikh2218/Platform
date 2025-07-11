# Proyecto Platform

![Estado del proyecto](https://img.shields.io/badge/estado-en%20desarrollo-yellow)

## Tabla de Contenidos
- [Resumen](#resumen)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Requisitos del Sistema](#requisitos-del-sistema)
- [Primeros Pasos](#primeros-pasos)
- [Comandos Rápidos](#comandos-rápidos)
- [Configuración](#configuración)
- [Despliegue en Producción](#despliegue-en-producción)
- [Submódulos de Git](#submódulos-de-git)
- [Contribuciones](#contribuciones)
- [Documentación y Recursos](#documentación-y-recursos)
- [Créditos y Licencia](#créditos-y-licencia)

## Resumen
Este proyecto es una plataforma web modular basada en microservicios, orquestada con Docker y Docker Compose. Incluye frontend en Node.js, backend en PHP y un proxy inverso con Nginx. Está diseñada para ser escalable y fácil de desplegar tanto en desarrollo como en producción.

## Estructura del Proyecto

- **`app_container`**: Este contenedor alberga la aplicación frontend en Node.js. El código fuente de esta aplicación probablemente se encuentra en el directorio `platform_app`.
- **`core_container`**: Este contenedor ejecuta los servicios backend usando PHP-FPM. Es responsable de la lógica de negocio y puede conectarse a una base de datos SQL Server para la persistencia de datos. El código fuente de este servicio probablemente se encuentra en el directorio `platform_core`.
- **`nginx_container`** (referido como `publisher` en `compose.yml`): Este contenedor utiliza Nginx como servidor web. Sirve los archivos estáticos del frontend y actúa como proxy inverso, reenviando las solicitudes dinámicas al `core_container` (backend PHP-FPM).

## Requisitos del Sistema
- Docker 20.10+
- Docker Compose v2+
- Git 2.20+
- Acceso a los submódulos privados (si aplica)

## Variables de entorno por entorno

Las variables de entorno están centralizadas y separadas por entorno en la carpeta `conf/`:
- `conf/.env.development` para desarrollo
- `conf/.env.production` para producción
- `conf/.env.test` para testing

Selecciona el archivo adecuado usando la opción `--env-file` al ejecutar Docker Compose.

## Comandos Rápidos
- Inicializar submódulos:
  ```bash
  git submodule update --init --recursive
  ```
- Despliegue en desarrollo:
  ```bash
  docker compose --env-file conf/.env.development up -d --build
  ```
  > Nota: `compose.override.yml` se aplica automáticamente si existe. Si no usas `--env-file`, Docker Compose solo leerá el archivo `.env` en el directorio actual.
- Despliegue en producción:
  ```bash
  ./deploy_prod.sh
  # o manualmente:
  docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml up -d --build
  ```
- Despliegue en test:
  ```bash
  docker compose --env-file conf/.env.test -f compose.yml -f compose.test.yml up -d --build
  ```
- Ver logs de un servicio:
  ```bash
  docker compose logs -f <servicio>
  ```
- Detener servicios:
  ```bash
  docker compose down
  ```

## Primeros Pasos

Sigue estos pasos para construir, ejecutar y acceder a la aplicación:

1. **Configuración del entorno:**
   Edita el archivo de variables de entorno correspondiente en `conf/` según el entorno que vayas a utilizar (por ejemplo, `conf/.env.development` para desarrollo, `conf/.env.production` para producción).
   > Recuerda ejecutar Docker Compose con la opción `--env-file conf/.env.development` para que se apliquen las variables de desarrollo.

2. **Construir y ejecutar la aplicación:**
   Abre tu terminal, navega al directorio raíz del proyecto (donde se encuentra el archivo `compose.yml`) y ejecuta el siguiente comando para construir las imágenes de Docker e iniciar los servicios en modo desacoplado:
   ```bash
   docker compose up -d --build
   ```

3. **Acceder a la aplicación:**
   - **Frontend (aplicación Node.js):** Una vez que los contenedores estén en ejecución, puedes acceder a la aplicación frontend navegando a `http://localhost:8080` en tu navegador web.
   - **Backend (servicios PHP vía Nginx):** Los servicios backend están detrás de Nginx. Por ejemplo, si tienes un endpoint backend en `/api/users`, podría estar accesible vía `http://localhost/core/api/users`. (Las rutas exactas dependerán del enrutamiento de la aplicación PHP en `platform_core/public/index.php`).

4. **Detener la aplicación:**
   Para detener todos los servicios en ejecución y eliminar los contenedores, redes y volúmenes creados por `docker compose up`, ejecuta el siguiente comando desde el directorio raíz del proyecto:
   ```bash
   docker compose down
   ```
   Si deseas detener los servicios sin eliminar los volúmenes (para preservar datos como el contenido de la base de datos si aplica), puedes usar:
   ```bash
   docker compose stop
   ```

## Configuración

Este proyecto tiene varios archivos clave de configuración que puedes necesitar inspeccionar o modificar para personalizaciones avanzadas:

- **Configuración de Nginx:**
    - `nginx_container/default.conf`: Define los bloques de servidor para Nginx, incluyendo cómo se manejan las solicitudes para el frontend (puerto 8080) y cómo las solicitudes backend a `/core/` se redirigen al servicio PHP-FPM. Es el archivo principal para modificar el comportamiento de Nginx.
    - `nginx_container/nginx.conf`: Archivo principal de configuración de Nginx. Incluye configuraciones globales y otros archivos de configuración como `default.conf`.

- **Configuración de PHP-FPM:**
    - `core_container/conf/www.conf`: Archivo de configuración del pool de PHP-FPM. Controla ajustes como usuario/grupo, dirección de escucha, gestión de procesos y variables de entorno para los scripts PHP.

- **Configuración de OpenSSL:**
    - `core_container/conf/openssl.cnf`: Contiene ajustes por defecto para OpenSSL, que puede ser usado por PHP para generar certificados autofirmados u otras operaciones criptográficas si la aplicación lo requiere.

- **Variables de entorno del backend:**
    - `core_container/platform_core/.env`: Archivo crítico para la aplicación backend PHP. Almacena variables como detalles de conexión a la base de datos, claves API, modo de la aplicación, etc.

- **Configuración de la aplicación frontend:**
    - El directorio `app_container/platform_app/` contiene la aplicación frontend en Node.js. Su configuración se gestiona mediante prácticas estándar de Node.js:
        - `package.json`: Define dependencias, scripts y metadatos del proyecto.
        - Archivos específicos del framework: Si el frontend usa un framework (React, Angular, Vue), habrá archivos de configuración adicionales (por ejemplo, `vue.config.js`, `angular.json` o archivos de entorno como `.env.development`).

## Despliegue en Producción
Consulta el [MANUAL_DESPLIEGUE.md](./docs/MANUAL_DESPLIEGUE.md) para instrucciones detalladas de despliegue en producción.

## Submódulos de Git
Este proyecto utiliza submódulos. Recuerda ejecutar:
```bash
git submodule update --init --recursive
```
antes de cualquier despliegue o actualización.

## Documentación y Recursos
- [Manual de Despliegue](./docs/MANUAL_DESPLIEGUE.md)
- [Arquitectura](./docs/ARCHITECTURE.md)

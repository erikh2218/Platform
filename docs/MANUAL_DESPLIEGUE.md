# Manual de Despliegue en Producción

Este manual describe los pasos necesarios para desplegar la plataforma en un entorno de producción utilizando Docker y Docker Compose, centralizando las variables de entorno en archivos separados por entorno dentro de la carpeta `conf/`.

## Requisitos previos

- Tener instalado Docker y Docker Compose en el sistema.
- Acceso a los repositorios privados de los submódulos (si aplica).
- Acceso a internet para descargar imágenes y dependencias.

## Importante: Submódulos de Git

Este proyecto utiliza submódulos de Git para incluir componentes externos o internos. Antes de realizar cualquier despliegue, asegúrate de inicializar y actualizar los submódulos ejecutando:

```bash
git submodule update --init --recursive
```

Si clonas el repositorio en un nuevo entorno, este paso es obligatorio para que todos los componentes estén presentes y actualizados.

## Centralización y separación de variables de entorno

Las variables de entorno necesarias para backend, frontend y configuración de cada entorno deben estar definidas en archivos separados dentro de la carpeta `conf/`:
- `conf/.env.development` para desarrollo
- `conf/.env.production` para producción
- `conf/.env.test` para testing

Selecciona el archivo adecuado usando la opción `--env-file` al ejecutar Docker Compose.

## Preparación del entorno de producción

1. **Clonar el repositorio principal:**
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd Platform
   ```

2. **Inicializar y actualizar los submódulos:**
   ```bash
   git submodule update --init --recursive
   ```

3. **Configurar el archivo de entorno de producción:**
   - Edita el archivo `conf/.env.production` con los valores apropiados para producción (base de datos, claves, endpoints, etc).
   - Si no existe, crea el archivo y copia las variables necesarias desde los ejemplos de backend y frontend.

## Despliegue de los servicios en producción

1. **Construir y levantar los contenedores en modo producción:**
   Desde la raíz del proyecto:
   ```bash
   docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml up -d --build
   ```

2. **Verificar el estado de los servicios:**
   ```bash
   docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml ps
   ```

3. **Acceso a la aplicación:**
   - **Frontend:** Accede a `http://<IP_O_DOMINIO>:8080` en tu navegador.
   - **Backend/API:** Accede a través de las rutas configuradas en Nginx, por ejemplo `http://<IP_O_DOMINIO>/core/api/...`.

4. **Detener y limpiar los servicios de producción:**
   - **Detener los servicios:**
     ```bash
     docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml stop
     ```
   - **Eliminar contenedores, redes y volúmenes creados:**
     ```bash
     docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml down
     ```

5. **Actualización de servicios en producción:**
   Si necesitas actualizar la aplicación en producción:
   ```bash
   docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml pull
   docker compose --env-file conf/.env.production -f compose.yml -f compose.prod.yml up -d --build
   ```

## Recomendaciones de seguridad
- Cambia todas las contraseñas y claves por valores seguros y únicos.
- Configura correctamente los puertos y el firewall del servidor.
- Habilita HTTPS en Nginx si la aplicación estará expuesta públicamente.
- Revisa los logs regularmente y mantén los servicios actualizados.

---

Sigue siempre las mejores prácticas de seguridad y realiza pruebas antes de desplegar cambios en producción.

Para dudas o problemas, consulta el archivo `README.md` principal o contacta al equipo de desarrollo.

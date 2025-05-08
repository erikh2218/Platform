# Usamos una imagen de Node.js para construir la aplicación
FROM node:22-alpine AS build

# Establecemos el directorio de trabajo
WORKDIR /app

RUN apk add --no-cache bash

# Copiamos los archivos de la aplicación
COPY ./platform_app /app

# Eliminamos la carpeta node_modules si existe
RUN rm -rf node_modules

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# mantener encendido el contenedor
CMD ["tail", "-f", "/dev/null"]
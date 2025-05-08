# Usar la imagen base de Nginx
FROM nginx:alpine

# Copiar tu configuración personalizada de Nginx
COPY ./default.conf /etc/nginx/conf.d/default.conf
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Copiar el archivo fastcgi-php.conf a la ubicación correspondiente en Nginx
COPY ./fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf

# Exponer el puerto 80 para el servidor web
EXPOSE 80
EXPOSE 8080
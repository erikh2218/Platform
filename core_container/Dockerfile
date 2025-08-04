# Usar la imagen oficial de PHP con extensiones necesarias para Laravel y SQL Server
FROM php:8.2-fpm

# Establecer la variable de entorno para aceptar el EULA de Microsoft
ENV ACCEPT_EULA=Y

# Establecer la zona horaria
RUN apt-get update && apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/America/Lima /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y lsb-release ca-certificates apt-transport-https software-properties-common

# Instalamos dependencias del sistema
RUN apt-get install -y \
    curl \
    nano \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    gnupg2 \
    iputils-ping \
    apt-transport-https \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd sockets

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Actualizar los paquetes e instalar msodbcsql17 y unixodbc-dev para SQL Server
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev unixodbc
RUN pecl install sqlsrv pdo_sqlsrv
RUN docker-php-ext-enable sqlsrv pdo_sqlsrv

# Instalar Composer desde la imagen oficial de Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo
WORKDIR /var/www/core

# Copiar codigo fuente
COPY ./platform_core /var/www/core

# Crear el directorio para el archivo PID y asignar permisos
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Copiar el archivo de configuración personalizado de PHP-FPM
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

# copiar el openssl.cnf modificado
COPY ./conf/openssl.cnf /etc/ssl/openssl.cnf

# Limpiar la caché de apt para reducir el tamaño de la imagen
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# # Exponer el puerto 9000 para PHP-FPM
EXPOSE 9000

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# # Comando por defecto para PHP-FPM
CMD ["php-fpm", "-F"]

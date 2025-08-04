#!/bin/bash
set -e

if [ -d "/var/www/core/storage" ]; then
    chmod -R 775 /var/www/core/storage
    chown -R www-data:www-data /var/www/core/storage
fi

if [ ! -d "/var/www/core/storage/framework/views" ]; then
    mkdir -p /var/www/core/storage/framework/views
fi

if [ -d "/var/www/core/bootstrap/cache" ]; then
    chmod -R 775 /var/www/core/bootstrap/cache
    chown -R www-data:www-data /var/www/core/bootstrap/cache
fi

if [ ! -d "/var/www/core/storage/framework/sessions" ]; then
    mkdir -p /var/www/core/storage/framework/sessions
    chmod -R 775 /var/www/core/storage/framework/sessions
    chown -R www-data:www-data /var/www/core/storage/framework/sessions
fi

if [ ! -d "vendor" ]; then
    composer install --no-interaction --prefer-dist --optimize-autoloader
fi

if [ -f "artisan" ]; then
    php artisan optimize:clear
fi

php artisan queue:work --timeout=30 --tries=3 &

exec "$@"
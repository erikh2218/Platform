#!/bin/sh
set -e

if [ ! -d "node_modules" ]; then
    npm install
fi

if [ "$APP_DEBUG" = "true" ]; then
    echo "APP_DEBUG es true: ejecutando 'npm run dev'..."
    npm run dev
else
    echo "APP_DEBUG no es true: ejecutando 'npm run build'..."
    npm run build
fi

exec "$@"
# Variables
DEV_COMPOSE_FILES = -f compose.yml -f compose.override.yml --env-file conf/.env
PROD_COMPOSE_FILES = -f compose.yml -f compose.prod.yml --env-file conf/.env

# Comando para desplegar en desarrollo
dev-up:
	docker compose $(DEV_COMPOSE_FILES) up -d

dev-build:
	docker compose $(DEV_COMPOSE_FILES) build

dev-down:
	docker compose $(DEV_COMPOSE_FILES) down

# Comando para desplegar en producción
prod-up:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d

prod-build:
	sudo docker compose $(PROD_COMPOSE_FILES) build

prod-down:
	sudo docker compose $(PROD_COMPOSE_FILES) down

# Comandos de utilidad
logs:
	docker compose $(DEV_COMPOSE_FILES) logs -f

restart:
	docker compose $(DEV_COMPOSE_FILES) restart

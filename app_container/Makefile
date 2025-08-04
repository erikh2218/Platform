# Variables
DEV_COMPOSE_FILES = -f ../compose.yml -f ../compose.override.yml --env-file ../conf/.env
PROD_COMPOSE_FILES = -f ../compose.yml -f ../compose.prod.yml --env-file ../conf/.env

# Comando para desplegar en desarrollo
dev-up:
	docker compose $(DEV_COMPOSE_FILES) up -d app

dev-build:
	docker compose $(DEV_COMPOSE_FILES) build app

dev-down:
	docker compose $(DEV_COMPOSE_FILES) stop app


# Comando para desplegar en producción
prod-up:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d app

prod-build:
	sudo docker compose $(PROD_COMPOSE_FILES) build app

prod-down:
	sudo docker compose $(PROD_COMPOSE_FILES) stop app

# Comandos de utilidad
logs:
	docker compose $(DEV_COMPOSE_FILES) logs -f app

restart:
	docker compose $(DEV_COMPOSE_FILES) restart app
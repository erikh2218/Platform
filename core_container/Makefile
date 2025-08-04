# Variables
DEV_COMPOSE_FILES = -f ../compose.yml -f ../compose.override.yml --env-file ../conf/.env
PROD_COMPOSE_FILES = -f ../compose.yml -f ../compose.prod.yml --env-file ../conf/.env

# Comando para desplegar en desarrollo
dev-up:
	docker compose $(DEV_COMPOSE_FILES) up -d core

dev-build:
	docker compose $(DEV_COMPOSE_FILES) build core

dev-down:
	docker compose $(DEV_COMPOSE_FILES) stop core


# Comando para desplegar en producción
prod-up:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d core

prod-build:
	sudo docker compose $(PROD_COMPOSE_FILES) build core

prod-down:
	sudo docker compose $(PROD_COMPOSE_FILES) stop core 

# Comandos de utilidad
logs:
	docker compose $(DEV_COMPOSE_FILES) logs -f core

restart:
	docker compose $(DEV_COMPOSE_FILES) restart core
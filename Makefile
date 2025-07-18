# Variables
DEV_COMPOSE_FILES = -f compose.yml -f compose.override.yml
PROD_COMPOSE_FILES = -f compose.yml -f compose.prod.yml

# Comando para desplegar en desarrollo
dev-up:
	docker compose $(DEV_COMPOSE_FILES) up -d

dev-build:
	docker compose $(DEV_COMPOSE_FILES) build

dev-down:
	docker compose $(DEV_COMPOSE_FILES) down

# Comandos para servicios individuales en desarrollo
dev-up-core:
	docker compose $(DEV_COMPOSE_FILES) up -d core

dev-up-app:
	docker compose $(DEV_COMPOSE_FILES) up -d app

dev-up-publisher:
	docker compose $(DEV_COMPOSE_FILES) up -d publisher

# Comandos para construir servicios individuales en desarrollo
dev-build-core:
	docker compose $(DEV_COMPOSE_FILES) build core

dev-build-app:
	docker compose $(DEV_COMPOSE_FILES) build app

dev-build-publisher:
	docker compose $(DEV_COMPOSE_FILES) build publisher

# Comandos para parar servicios individuales en desarrollo
dev-down-core:
	docker compose $(DEV_COMPOSE_FILES) stop core

dev-down-app:
	docker compose $(DEV_COMPOSE_FILES) stop app

dev-down-publisher:
	docker compose $(DEV_COMPOSE_FILES) stop publisher

# Comando para desplegar en producción
prod-up:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d

prod-build:
	sudo docker compose $(PROD_COMPOSE_FILES) build

prod-down:
	sudo docker compose $(PROD_COMPOSE_FILES) down

# Comandos para servicios individuales en producción
prod-up-core:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d core

prod-up-app:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d app

prod-up-publisher:
	sudo docker compose $(PROD_COMPOSE_FILES) up -d publisher

# Comandos para construir servicios individuales en producción
prod-build-core:
	sudo docker compose $(PROD_COMPOSE_FILES) build core

prod-build-app:
	sudo docker compose $(PROD_COMPOSE_FILES) build app

prod-build-publisher:
	sudo docker compose $(PROD_COMPOSE_FILES) build publisher

# Comandos para parar servicios individuales en producción
prod-down-core:
	sudo docker compose $(PROD_COMPOSE_FILES) stop core

prod-down-app:
	sudo docker compose $(PROD_COMPOSE_FILES) stop app

prod-down-publisher:
	sudo docker compose $(PROD_COMPOSE_FILES) stop publisher

# Comandos de utilidad
logs:
	docker compose $(DEV_COMPOSE_FILES) logs -f

logs-core:
	docker compose $(DEV_COMPOSE_FILES) logs -f core

logs-app:
	docker compose $(DEV_COMPOSE_FILES) logs -f app

logs-publisher:
	docker compose $(DEV_COMPOSE_FILES) logs -f publisher

restart:
	docker compose $(DEV_COMPOSE_FILES) restart

restart-core:
	docker compose $(DEV_COMPOSE_FILES) restart core

restart-app:
	docker compose $(DEV_COMPOSE_FILES) restart app

restart-publisher:
	docker compose $(DEV_COMPOSE_FILES) restart publisher
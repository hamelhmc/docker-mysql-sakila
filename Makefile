# Makefile para tareas de Docker

# Detectar el sistema operativo
ifeq ($(OS),Windows_NT)
    DETECTED_OS := Windows
    SHELL_TYPE := $(if $(findstring pwsh,$(SHELL)),PowerShell,$(if $(findstring cmd.exe,$(SHELL)),Cmd,Unknown))
    ifeq ($(SHELL_TYPE),PowerShell)
        READ_COMMAND := $$MYSQL_PASSWORD = Read-Host "Ingrese la contraseña de MySQL" -AsSecureString; $$MYSQL_PASSWORD = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($$MYSQL_PASSWORD))
    else
        READ_COMMAND := set /p MYSQL_PASSWORD="Ingrese la contraseña de MySQL: "
    endif
else
    DETECTED_OS := $(shell uname -s)
    READ_COMMAND := read -p "Ingrese la contraseña de MySQL: " MYSQL_PASSWORD; 
endif

# Configuración de comandos según el sistema operativo
ifeq ($(DETECTED_OS),Windows)
    RM := del /Q
    ECHO := echo
else
    RM := rm -f
    ECHO := echo
endif

# Variables
DOCKER_COMPOSE_FILE = docker/docker-compose.yaml
ENV_FILE = .env

# Targets
.PHONY: ayuda
ayuda:
	@$(ECHO) "Uso: make [objetivo]"
	@$(ECHO) "Objetivos:"
	@$(ECHO) "  env-file         Crear y configurar el archivo .env"
	@$(ECHO) "  start            Iniciar los servicios de Docker"
	@$(ECHO) "  import-data      Importar datos de Sakila (solo la primera vez)"
	@$(ECHO) "  access-phpmyadmin Acceder a PHPMyAdmin en el navegador"
	@$(ECHO) "  stop             Detener y limpiar los servicios de Docker"
	@$(ECHO) "  logs             Ver los logs de los servicios de Docker"
	@$(ECHO) "  clean            Eliminar el archivo .env"
	@$(ECHO) "  open-phpmyadmin  Abrir PHPMyAdmin en el navegador"
	@$(ECHO) "  clean-images     Eliminar todas las imágenes Docker"
	@$(ECHO) "  clean-containers Eliminar todos los contenedores Docker"
	@$(ECHO) "  clean-volumes    Eliminar todos los volúmenes Docker"

.PHONY: env-file
env-file:
	$(ECHO) "MYSQL_ROOT_PASSWORD=contraseña_secreta" > $(ENV_FILE)

.PHONY: start
start: env-file
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) up -d

.PHONY: import-data
import-data: start
	@$(READ_COMMAND) \
	docker exec -i docker-mysql-sakila-1 bash -c "mysql -u root -p$$MYSQL_PASSWORD < /root/sakila-db/sakila-schema.sql"; \
	docker exec -i docker-mysql-sakila-1 bash -c "mysql -u root -p$$MYSQL_PASSWORD < /root/sakila-db/sakila-data.sql"

.PHONY: access-phpmyadmin
access-phpmyadmin:
	$(ECHO) "Accede a PHPMyAdmin: http://localhost:9443/"
	$(ECHO) "Usuario: root"
	$(ECHO) "Contraseña: contraseña_secreta"

.PHONY: stop
stop:
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) down

.PHONY: logs
logs:
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) logs -f

.PHONY: clean
clean:
	$(RM) $(ENV_FILE)

.PHONY: open-phpmyadmin
open-phpmyadmin: access-phpmyadmin
	$(OPEN) "http://localhost:9443/"

.PHONY: clean-images
clean-images:
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	docker image prune -af

.PHONY: clean-containers
clean-containers:
	docker-compose --env-file $(ENV_FILE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans

.PHONY: clean-volumes
clean-volumes:
	docker volume prune -f

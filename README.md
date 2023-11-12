# Docker MySQL Sakila

Este proyecto proporciona un entorno Dockerizado con un servidor MySQL que utiliza la base de datos de ejemplo Sakila. También incluye un servicio de PHPMyAdmin para administrar la base de datos.

## Estructura del Proyecto

```
docker-mysql-sakila/
│
├── db_data/          # Carpeta para almacenar datos persistentes de MySQL
│
├── docker/
│   ├── Dockerfile    # Archivo Dockerfile personalizado
│   └── docker-compose.yaml  # Archivo docker-compose para la configuración de servicios
│
├── .gitignore        # Archivo para especificar archivos y carpetas a ignorar por git
├── .env              # Archivo de entorno para configuración (define MYSQL_ROOT_PASSWORD)
├── Makefile          # Archivo Makefile para automatizar tareas de Docker
└── README.md         # Archivo README con instrucciones
```

## Instrucciones de Uso

### Requisitos Previos

- Docker instalado en tu máquina.

### Pasos para Ejecutar

1. **Clona el repositorio:**

```bash
git clone https://github.com/hamelhmc/docker-mysql-sakila.git
```

2. **Navega al directorio del proyecto:**

```bash
cd docker-mysql-sakila

```

3. **Crea y configura el archivo de entorno `.env`:**

```
MYSQL_ROOT_PASSWORD=contraseña_secreta
```

4. **Levanta los servicios:**

```bash
docker-compose --env-file .env -f docker/docker-compose.yaml up -d
```

5. **Importa datos de Sakila (solo necesario la primera vez):**

> Asegúrate de reemplazar <contraseña_configurada_en_env> con la contraseña que configuraste en el archivo .env.

```bash
docker exec -i docker-mysql-sakila-1 bash -c "mysql -u root -p<contraseña_configurada_en_env> < /root/sakila-db/sakila-schema.sql"
docker exec -i docker-mysql-sakila-1 bash -c "mysql -u root -p<contraseña_configurada_en_env> < /root/sakila-db/sakila-data.sql"
```

6. **Accede a PHPMyAdmin desde tu navegador:**

[localhost](http://localhost:9443/)

- Usuario: `root`
- Contraseña: La que hayas configurado en el archivo `.env`

### Detener y Limpiar

Si deseas detener y eliminar los contenedores y volúmenes, ejecuta:

```bash
docker-compose down
```

Esto detendrá los servicios y eliminará los contenedores y volúmenes asociados.

### Notas Adicionales

- La carpeta `db_data` contiene datos persistentes de MySQL.
- Puedes personalizar la configuración de MySQL y PHPMyAdmin en el archivo `docker/docker-compose.yaml`.

**¡Importante!**
Este entorno es solo para fines educativos y de desarrollo. No se recomienda para uso en entornos de producción.

> Este es un ejemplo básico. Puedes personalizar el contenido según tus necesidades específicas. Asegúrate de proporcionar información relevante sobre cómo configurar, utilizar y personalizar tu entorno Docker.

## Utilizando el Makefile

#### Instalación de Make (si aún no está instalado)

- **Linux:**

```bash
  sudo apt-get update
  sudo apt-get install make
```

- **macOS:**

```bash
  brew install make
```

- **Windows:**

[Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm)

#### Uso del Makefile

Una vez que Make está instalado, puedes utilizar el Makefile para simplificar tareas relacionadas con Docker. Aquí hay algunos comandos útiles:

| Comando                | Descripción                                    |
| ---------------------- | ---------------------------------------------- |
| make env-file          | Crear y configurar el archivo .env             |
| make start             | Iniciar los servicios de Docker                |
| make import-data       | Importar datos de Sakila (solo la primera vez) |
| make access-phpmyadmin | Acceder a PHPMyAdmin desde el navegador        |
| make stop              | Detener y limpiar los servicios de Docker      |
| make clean             | Eliminar el archivo .env                       |
| make open-phpmyadmin   | Abrir PHPMyAdmin en el navegador               |
| make logs              | Ver los logs de los servicios de Docker        |
| make clean-images      | Eliminar todas las imágenes Docker             |
| make clean-containers  | Eliminar todos los contenedores Docker         |
| make clean-volumes     | Eliminar todos los volúmenes Docker            |

Estos comandos te permitirán ejecutar tareas comunes de Docker de manera sencilla. Asegúrate de revisar el Makefile para conocer todas las tareas disponibles.

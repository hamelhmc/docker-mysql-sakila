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

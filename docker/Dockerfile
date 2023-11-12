# Use the official MySQL image based on Debian
FROM mysql:latest

# Install required dependencies
RUN microdnf install python3 python3-pip wget unzip

# Create a directory for the Sakila database files
WORKDIR /root

# Download and unzip the Sakila database
RUN wget https://downloads.mysql.com/docs/sakila-db.zip ; unzip sakila-db.zip 
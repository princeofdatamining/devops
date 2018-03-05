yum install -y mariadb-server
systemctl enable mariadb
systemctl restart mariadb

# mysql_secure_installation
# CREATE USER 'user'@'localhost' IDENTIFIED BY 'pass';
# GRANT ALL PRIVILEGES ON *.* TO 'user'@'localhost' WITH GRANT OPTION;
# CREATE DATABASE database CHARSET utf8mb4 COLLATE utf8mb4_general_ci;

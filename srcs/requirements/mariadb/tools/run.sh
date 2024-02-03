service mariadb start

mysqladmin -u root shutdown

exec mysqld_safe

#docker exec -it <docker ps id> /bin/sh
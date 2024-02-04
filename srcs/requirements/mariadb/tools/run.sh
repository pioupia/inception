service mariadb status
status=$?

while [ $status -ne 0 ]
do
	service mariadb restart
	sleep 2
	service mariadb status
	status=$?
done

echo "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"

mysql -e "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_PASSWORD';"

echo "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;GRANT ALL ON '$DB_NAME'.* TO '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_PASSWORD';FLUSH PRIVILEGES;"
mysql -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;GRANT ALL ON \`$DB_NAME\`.* TO '$DB_USERNAME'@'localhost' IDENTIFIED BY '$DB_PASSWORD';FLUSH PRIVILEGES;"

mysqladmin -u root shutdown

exec mysqld_safe --bind-address=0.0.0.0
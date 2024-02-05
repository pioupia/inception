service mariadb status
status=$?

while [ $status -ne 0 ]
do
	service mariadb restart
	sleep 2
	service mariadb status 1>/dev/null
	status=$?
done


if [ ! -d /home/pioupia/mariadb/$DB_NAME ]; then
	mysql -e "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;\
		GRANT ALL ON \`$DB_NAME\`.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';\
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ADMIN_PASS';\
		DROP DATABASE test;\
		DELETE FROM mysql.user WHERE user = ' ';\
		DROP USER IF EXISTS test;\
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';\
		FLUSH PRIVILEGES;"
else
	echo The database is already configured
fi

mysqladmin -u root -p$DB_ADMIN_PASS shutdown

exec "$@"
service mariadb status
status=$?

while [ $status -ne 0 ]
do
	service mariadb restart
	sleep 2
	service mariadb status 1>/dev/null
	status=$?
done


if [ ! -d /var/lib/mysql/$DB_NAME ]; then
	mysql -e "CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;\
		GRANT ALL ON \`$DB_NAME\`.* TO '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';\
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ADMIN_PASS';\
		DROP DATABASE test;\
		DELETE FROM mysql.user WHERE user = ' ';\
		DROP USER IF EXISTS test;\
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';\
		FLUSH PRIVILEGES;"
	
	# bonus
	mysql --password="'$DB_ADMIN_PASS'" -e "CREATE USER IF NOT EXISTS '$DB_FTP_USERNAME'@'%' IDENTIFIED BY '$DB_FTP_PASSWORD';"
	mysql --password="'$DB_ADMIN_PASS'" -e "CREATE DATABASE IF NOT EXISTS \`$DB_FTP_NAME\` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;\
		GRANT ALL ON \`$DB_FTP_NAME\`.* TO '$DB_FTP_USERNAME'@'%' IDENTIFIED BY '$DB_FTP_PASSWORD';\
		USE $DB_FTP_NAME;
		CREATE TABLE users ( user varchar(30) NOT NULL, password varchar(64) NOT NULL, home varchar(128) NOT NULL, bandwidth_limit_upload smallint(5) NOT NULL default 0, bandwidth_limit_download smallint(5) NOT NULL default 0, ip_allow varchar(15) NOT NULL default 'any', quota smallint(5) NOT NULL default '0', quota_files int(11) NOT NULL default 0, active enum('yes','no') NOT NULL default 'yes', PRIMARY KEY (user), UNIQUE KEY User (user) ) TYPE=MyISAM;
		INSERT INTO users (user, password, home) VALUES ('$FTP_USER', MD5('$FTP_PASSWORD'), '/home/pioupia/data/wordpress/wp-content');
		FLUSH PRIVILEGES;"
else
	echo The database is already configured
fi

mysqladmin -u root -p$DB_ADMIN_PASS shutdown

exec "$@"
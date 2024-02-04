cd /home/pioupia/wordpress

function exit_command_failed {
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

function wait_for_db {
	mysql -u"$DB_USER" --password="'$DB_PASSWORD'" -e "SHOW ENGINE INNODB STATUS;"
	status=$?
	while [ $status -ne 0 ];
	do
		sleep 2
		nc mariadb 3306
		status=$?
	done
}

if [ ! -f wp-config.php ]; then
	wait_for_db
	wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --dbhost=mariadb
	exit_command_failed
	wp db create
	wp core install --url=https://pioupia.42.fr --title="Inception" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_MAIL"
	wp user create "$USER" "$USER_MAIL" --user_pass="$USER_PASS"
else
	echo "The WordPress configuration is already set"
fi

exec "$@"
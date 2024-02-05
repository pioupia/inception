function exit_command_failed {
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

if [ ! -f wp-config.php ]; then
	wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --dbhost=mariadb
	exit_command_failed
	wp db create
	wp core install --url=https://pioupia.42.fr --title="Inception" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_MAIL"
	wp user create "$USER" "$USER_MAIL" --user_pass="$USER_PASS"
	sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0;/g' /etc/php82/php.ini
	sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php82/php-fpm.d/www.conf
else
	echo "The WordPress configuration is already set"
fi

exec "$@"
function exit_command_failed {
	if [ $? -ne 0 ] && [ ! -f wp-config.php ]; then
		exit 1
	fi
}

if [ ! -f wp-config.php ]; then
	wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --dbhost=mariadb
	exit_command_failed
	wp db create
	wp user create "$USER" "$USER_MAIL" --user_pass="$USER_PASS"
	wp core install --url=https://pioupia.42.fr --title="Inception" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_MAIL"
	wp install redis-cache
	wp config set WP_REDIS_HOST "redis"
	wp config set WP_REDIS_DATABASE 0
	wp plugin activate redis-cache
	wp redis enable
else
	echo "The WordPress configuration is already set"
fi

exec "$@"
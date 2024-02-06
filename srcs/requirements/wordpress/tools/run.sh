if [ ! -f wp-config.php ]; then
	wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --dbhost=mariadb
	wp db create
	wp core install --url=https://pioupia.42.fr --title="Inception" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_MAIL"
	wp user create "$USER" "$USER_MAIL" --user_pass="$USER_PASS"
else
	echo "The WordPress configuration is already set"
fi

exec "$@"
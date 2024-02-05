cd /home/pioupia/wordpress

function exit_command_failed {
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

if [ ! -f wp-config.php ]; then
	wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD --dbhost=mariadb --extra-php
	exit_command_failed
	wp db create
	wp core install --url="https://pioupia.42.fr" --title="Inception" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_MAIL"
	wp user create "$USER" "$USER_MAIL" --user_pass="$USER_PASS"
	sed -i 's/; cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php81/php.ini
else
	echo "The WordPress configuration is already set"
fi

wp option get siteurl
wp option list --search="http:*" --fields=option_name

exec "$@"
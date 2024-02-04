cd /home/pioupia/wordpress

function exit_command_failed {
	if [ $? -ne 0 ]; then
		exit 1
	fi
}

function wait_for_db {
	nc mariadb 3306 1>/dev/null
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
	exit_command_failed
	wp core install --url=pioupia.42.fr --title="Inception" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_MAIL
	exit_command_failed
else
	echo "The WordPress configuration is already set"
fi

exec "$@"
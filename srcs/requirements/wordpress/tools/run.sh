cd /wordpress

function exit_command_failed {
	if [ $? -ne 0 ]; then
		exit 1
	fi
}


mysql -e "SELECT version();"

wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD
exit_command_failed
wp db create
exit_command_failed
wp core install --url=pioupia.42.fr --title="Inception" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_MAIL
exit_command_failed
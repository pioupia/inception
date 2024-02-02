FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add php php-fpm wget php-phar php-curl php-mysqli

# Download wordpress archive
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	mkdir wordpress && \
	cd wordpress && \
	wp core download && \
	wp config create --dbname=$DB_NAME --dbuser=$DB_USERNAME --dbpass=$DB_PASSWORD && \
	wp db create && \
	wp core install --url=pioupia.42.fr --title="Inception" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_MAIL

CMD [ "wp", "server", "--port=9000" ]
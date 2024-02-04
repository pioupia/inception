FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add php php-fpm wget php-phar php-curl php-mysqli mysql-client

WORKDIR /home/pioupia/wordpress

# Download wordpress archive
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download

ADD tools/run.sh /usr/local/bin/run.sh

ENTRYPOINT [ "/bin/sh", "/usr/local/bin/run.sh" ]

EXPOSE 9000

CMD [ "wp", "server", "--host=0.0.0.0", "--port=9000" ]
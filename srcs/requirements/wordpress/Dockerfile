FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add php82 fcgi php82-cgi php82-fpm php82-mysqli php82-phar mysql-client php82-iconv php82-mbstring && \
	ln -s /usr/bin/php82 /usr/bin/php

WORKDIR /home/pioupia/wordpress

ADD tools/run.sh /usr/local/bin/run.sh

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download

ENTRYPOINT [ "/bin/sh", "/usr/local/bin/run.sh" ]

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm82", "-F" ]
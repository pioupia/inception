FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add php82 fcgi php82-cgi php82-fpm php82-mysqli php82-phar mysql-client php82-iconv php82-mbstring php82-tokenizer php82-redis php82-ctype && \
	ln -s /usr/bin/php82 /usr/bin/php

WORKDIR /var/www/wordpress/

ADD tools/run.sh /usr/local/bin/run.sh

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download && \
	sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0;/g' /etc/php82/php.ini && \
	sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php82/php-fpm.d/www.conf

ENTRYPOINT [ "/bin/sh", "/usr/local/bin/run.sh" ]

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm82", "-F" ]
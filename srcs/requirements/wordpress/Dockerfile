FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add php82 fcgi php82-cgi php82-fpm php82-mysqli php82-phar && \
	ln -s /usr/bin/php82 /usr/bin/php

WORKDIR /home/pioupia/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	wp core download

ADD tools/run.sh /usr/local/bin/run.sh
ADD tools/www.conf /etc/php82/php-fpm.d/www.conf

ENTRYPOINT [ "/bin/sh", "/usr/local/bin/run.sh" ]

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm82", "-F" ]
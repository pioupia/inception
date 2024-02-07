FROM alpine:3.18

RUN apk update && \
	apk add php82 php82-fpm php82-session php82-mysqli && \
	ln -s /usr/bin/php82 /usr/bin/php

WORKDIR /var/www/adminer/

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php -O adminer.php && \
	sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0;/g' /etc/php82/php.ini && \
	sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php82/php-fpm.d/www.conf

EXPOSE 9000

CMD [ "/usr/sbin/php-fpm82", "-F" ]
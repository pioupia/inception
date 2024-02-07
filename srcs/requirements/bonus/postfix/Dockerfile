FROM alpine:3.18

RUN apk update && \
	apk add postfix

ADD conf/main.cf /etc/postfix/main.cf

RUN mkdir -p /var/www/roundcube && \
	cd /var/www/roundcube && \
	wget https://github.com/roundcube/roundcubemail/releases/download/1.5.6/roundcubemail-1.5.6-complete.tar.gz -O roundcubemail.tar.gz && \
	tar zxvf roundcubemail.tar.gz &>/dev/null && \
	rm roundcubemail.tar.gz && \
	mv roundcubemail-1.5.6 roundcubemail

EXPOSE 25 465 587

CMD [ "/usr/bin/nc", "-l", "-p", "2000" ]
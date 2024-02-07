FROM alpine:3.18

RUN apk update && \
	apk add postfix

ADD conf/main.cf /etc/postfix/main.cf

RUN mkdir -p /usr/share/webapps && \
	cd /usr/share/webapps && \
	wget https://github.com/roundcube/roundcubemail/releases/download/1.5.6/roundcubemail-1.5.6-complete.tar.gz -O roundcubemail.tar.gz && \
	tar zxvf roundcubemail.tar.gz && \
	rm roundcubemail.tar.gz && \
	mv roundcubemail-1.5.6 roundcubemail && \
	chmod 775 -R roundcubemail
EXPOSE 25 465 587

CMD [ "postfix", "reload" ]
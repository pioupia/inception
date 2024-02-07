FROM alpine:3.18

RUN apk update && \
	apk add nodejs npm git

WORKDIR /var/www/

RUN git clone https://github.com/louislam/uptime-kuma.git kuma && \
	cd kuma && \
	npm run setup && \
	echo "nginx pioupia.42.fr" >> /etc/hosts

WORKDIR /var/www/kuma

ADD conf/script.sh /usr/bin/script.sh

EXPOSE 3001

ENTRYPOINT [ "/bin/sh", "/usr/bin/script.sh" ]

CMD [ "node", "server/server.js" ]
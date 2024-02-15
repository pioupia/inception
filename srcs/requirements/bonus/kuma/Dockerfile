FROM alpine:3.18

RUN apk update && \
	apk add nodejs npm git

WORKDIR /var/www/kuma

ADD conf/script.sh /usr/bin/script.sh

EXPOSE 3001

ENTRYPOINT [ "/bin/sh", "/usr/bin/script.sh" ]
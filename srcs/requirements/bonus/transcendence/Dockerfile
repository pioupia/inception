FROM alpine:3.18

RUN apk update && \
	apk add python3

ADD conf/index.html /var/www/index.html

EXPOSE 8000

WORKDIR /var/www

CMD [ "python3", "-m", "http.server" ]
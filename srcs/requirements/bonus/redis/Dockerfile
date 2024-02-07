FROM alpine:3.18

RUN apk update && \
	apk add redis

EXPOSE 6379

CMD [ "redis-server", "--protected-mode", "no" ]
FROM alpine:3.18

RUN apk update && \
	apk add redis

# dir /var/lib/redis <- data directory
# redis.conf <- config file

EXPOSE 6379

CMD [ "redis-server", "-F" ]
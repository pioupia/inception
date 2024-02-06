FROM alpine:3.18

RUN apk update && \
	apk add redis

ADD conf/redis.conf /etc/redis.conf

RUN sed -i "s/REQUIRE_REDIS_PASS/$REDIS_PASSWORD/" /etc/redis.conf

EXPOSE 6379

CMD [ "redis-server" ]
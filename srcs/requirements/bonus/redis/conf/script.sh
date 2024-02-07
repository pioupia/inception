#!/bin/sh

sed -i "s/REQUIRE_REDIS_PASS/$REDIS_PASSWORD/g" /etc/redis.conf
exec "$@"
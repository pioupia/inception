IP=$(nslookup -type=MX nginx | head -1 | awk '{print $2}')

echo "$IP pioupia.42.fr adminer.pioupia.42.fr kuma.pioupia.42.fr pong.pioupia.42.fr" >> /etc/hosts

exec "$@"
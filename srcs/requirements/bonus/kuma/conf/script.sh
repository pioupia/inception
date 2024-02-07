IP=$(ping nginx -c 1 | head -1 | awk '{print $3}' | tr -d '():')

echo "$IP pioupia.42.fr adminer.pioupia.42.fr kuma.pioupia.42.fr pong.pioupia.42.fr" >> /etc/hosts

exec "$@"
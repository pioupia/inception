if [ ! -d /var/www/kuma/kuma ]; then
	cd /var/www/kuma
	git clone https://github.com/louislam/uptime-kuma.git kuma
	cd kuma
	npm run setup
else
	cd /var/www/kuma/kuma
fi

IP=$(ping nginx -c 1 | head -1 | awk '{print $3}' | tr -d '():')
echo "$IP pioupia.42.fr adminer.pioupia.42.fr kuma.pioupia.42.fr transcendence.pioupia.42.fr" >> /etc/hosts

node server/server.js
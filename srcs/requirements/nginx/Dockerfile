FROM alpine:3.18

# Update the system and install Nginx
RUN apk update && \
	apk add nginx openssl

# Adding a user and a group 'www'
RUN adduser -D -g 'www' www && \
	mkdir -p /var/www/html && \
	mkdir -p /etc/nginx/ssl/ && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /var/www

# Copy the local nginx config to the containered nginx config
ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN echo $SSL_PASSWORD > /etc/nginx/ssl/global.pass

RUN openssl req -x509 -newkey rsa:4096 -days 365 -keyout /etc/nginx/ssl/ca-key.key \
	-out /etc/nginx/ssl/ca-cert.crt -subj "/C=FR/ST=Haut-Rhin/L=Mulhouse/O=42/OU=school/CN=pioupia.42.fr/emailAddress=pioupia@student.42.fr"	\
	-passout "pass:$SSL_PASSWORD"

EXPOSE 443

CMD [ "nginx", "-g",  "daemon off;" ]
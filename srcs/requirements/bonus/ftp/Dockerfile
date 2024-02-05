FROM debian:bullseye

RUN apt update && \
	apt install pure-ftpd-mysql mariadb-client -y

RUN groupadd -g 2001 ftpgroup && \
	useradd -u 2001 -s /bin/false -d /bin/null -c "pureftpd user" -g ftpgroup ftpuser

# Le chroot doit bien etre gere dans wp-content du mysql. Les users ne doivent pas pouvoir sortir.
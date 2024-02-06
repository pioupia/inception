FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get install libpam-dev libcap2-dev libldap2-dev default-libmysqlclient-dev libpq-dev libsodium-dev libssl-dev pure-ftpd-mysql mariadb-client netcat-traditional -y

RUN groupadd -g 2001 ftpgroup && \
	useradd -u 2001 -s /bin/false -d /bin/null -c "pureftpd user" -g ftpgroup ftpuser

ADD conf/mysql.conf /etc/pure-ftpd/db/mysql.conf

RUN echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone && \
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir

# Fix the capabilities problems
# We should save the both .deb files like in "conf" directory and push them
# to avoid the build of everything each time
RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
	apt-get update && \
    mkdir /tmp/pure-ftpd-mysql && \
    cd /tmp/pure-ftpd-mysql && \
    apt-get source pure-ftpd-mysql && \
	cd pure-ftpd-* && \
	sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \
	dpkg-buildpackage -b -uc && \
	dpkg -i /tmp/pure-ftpd-mysql/pure-ftpd-common*.deb && \
    dpkg -i /tmp/pure-ftpd-mysql/pure-ftpd-mysql*.deb && \
    apt-mark hold pure-ftpd pure-ftpd-mysql pure-ftpd-common && \
    apt-get clean && \
	cd / && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/pure-ftpd-mysql && \
	/etc/init.d/pure-ftpd-mysql restart

# Le chroot doit bien etre gere dans wp-content du mysql. Les users ne doivent pas pouvoir sortir.

CMD [ "/bin/nc", "-l", "-p", "2000" ]
FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
	apt-get install pure-ftpd-mysql mariadb-client netcat-traditional -y

RUN groupadd -g 2001 ftpgroup && \
	useradd -u 2001 -s /bin/false -d /bin/null -c "pureftpd user" -g ftpgroup ftpuser

ADD conf/mysql.conf /etc/pure-ftpd/db/mysql.conf

RUN echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone && \
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir && \
	mkdir -p /tmp/pure-ftpd-install

ADD conf/pure-ftpd-common.deb /tmp/pure-ftpd-install
ADD conf/pure-ftpd-mysql.deb /tmp/pure-ftpd-install
ADD conf/pure-ftpd-mysql-dbgsym.deb /tmp/pure-ftpd-install

RUN echo "deb-src http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
	apt-get update && \
	dpkg -i /tmp/pure-ftpd-install/*.deb && \
    apt-mark hold pure-ftpd pure-ftpd-mysql pure-ftpd-common && \
    apt-get clean && \
	cd / && \
    rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/pure-ftpd-install && \
	/etc/init.d/pure-ftpd-mysql restart

CMD [ "/bin/nc", "-l", "-p", "2000" ]
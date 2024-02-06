FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

ARG DB_FTP_USERNAME
ARG DB_FTP_PASSWORD
ARG DB_FTP_NAME

RUN apt-get update && \
	apt-get install pure-ftpd-mysql mariadb-client netcat-traditional vim -y

RUN groupadd -g 2001 ftpgroup && \
	useradd -u 2001 -s /bin/false -d /bin/null -c "pureftpd user" -g ftpgroup ftpuser

ADD conf/mysql.conf /etc/pure-ftpd/db/mysql.conf

RUN sed -i "1iMYSQLUser\t\t\t$DB_FTP_USERNAME\n\
MYSQLPassword\t\t$DB_FTP_PASSWORD\n\
MYSQLDatabase\t\t$DB_FTP_NAME\n" /etc/pure-ftpd/db/mysql.conf

RUN echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone && \
	echo "yes" > /etc/pure-ftpd/conf/CreateHomeDir && \
	echo "yes" > /etc/pure-ftpd/conf/NoAnonymous && \
	echo "yes" > /etc/pure-ftpd/conf/IPV4Only && \
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

EXPOSE 21

# -d for debug
CMD [ "/usr/sbin/pure-ftpd-mysql", "-l", "mysql:/etc/pure-ftpd/db/mysql.conf", "-l", "pam", "-E", "-J", "HIGH", "-O", "clf:/var/log/pure-ftpd/transfer.log", "-u", "1000", "-A", "-j", "-4" ]
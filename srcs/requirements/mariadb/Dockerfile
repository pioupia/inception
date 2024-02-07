FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add mariadb mysql-client openrc udev-init-scripts-openrc

RUN mysql_install_db --user=mysql \
    --datadir=/var/lib/mysql/

RUN mkdir /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

RUN mkdir -p /run/openrc/exclusive && \
	touch /run/openrc/softlevel

ADD tools/run.sh /usr/bin/run.sh

ADD conf/mysql.initial.sql /var/lib/mysql.initial.sql
ADD conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

ENTRYPOINT [ "/bin/sh", "/usr/bin/run.sh" ]

CMD [ "mysqld_safe", "--bind-address=0.0.0.0" ]
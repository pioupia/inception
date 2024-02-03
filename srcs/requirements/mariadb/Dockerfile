FROM alpine:3.18

# Update the system and install php
RUN apk update && \
	apk add mariadb mysql-client openrc udev-init-scripts-openrc

RUN mysql_install_db --user=mysql \
    --datadir=/var/lib/mysql

RUN mkdir /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

RUN mkdir -p /run/openrc/exclusive && \
	touch /run/openrc/softlevel

COPY tools/run.sh run.sh

ENTRYPOINT [ "/bin/sh", "run.sh" ]
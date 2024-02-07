FROM alpine:3.18


RUN apk update && \
	apk add postfix

RUN mkdir -p /var/spool/mail/vhosts && \
	addgroup vmail && \
	chown vmail:vmail /var/spool/mail/vhosts

# cat /etc/passwd | grep vmail | awk -F":" '{print $3}'

CMD [ "/bin/nc", "-l", "-p", "2000" ]
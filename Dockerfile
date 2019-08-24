FROM alpine

LABEL maintainer="Ghostry <ghostry.green@gmail.com>"

RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk add --no-cache pure-ftpd@testing="1.0.47-r3"

ADD start.sh /start.sh
ADD pure-ftpd.conf /etc/pure-ftpd.conf
ADD pureftpd-mysql.conf /etc/pureftpd-mysql.conf
ADD mysql.sql /mysql.sql
ADD pure-ftpd.pem /etc/ssl/private/pure-ftpd.pem

RUN chmod +x /start.sh \
    && chmod 600 /etc/ssl/private/pure-ftpd.pem \
    && adduser -s /sbin/nologin -D ftpuser \
    && mkdir /dirs -p \
    && chown ftpuser:ftpuser /dirs/ -R

WORKDIR /

VOLUME ["/dirs/"]

EXPOSE 21

CMD ["/start.sh"]
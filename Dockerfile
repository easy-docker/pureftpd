FROM ubuntu as builder
WORKDIR /
RUN apt update \
    && apt install -y dpkg-dev libpam-dev libcap2-dev libldap2-dev default-libmysqlclient-dev libpq-dev libssl-dev openssl po-debconf debhelper wget checkinstall
RUN wget https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.49.tar.bz2 \
    && tar xvjpf pure-ftpd-1*.tar.bz2 \
    && cd pure-ftpd-1.0.49 \
    && ./configure --help \
    && ./configure --with-mysql --with-virtualchroot --with-tls --with-everything --without-capabilities \
    && make \
    && checkinstall -D -y

FROM ubuntu

LABEL maintainer="Ghostry <ghostry.green@gmail.com>"

COPY --from=builder /pure-ftpd-1.0.49/pure-ftpd_1.0.49-1_amd64.deb /pure-ftpd_1.0.49-1_amd64.deb

RUN apt update && apt install -y openssl  libmysqlclient-dev \
    && dpkg -i /pure-ftpd_1.0.49-1_amd64.deb \
    && rm -f /pure-ftpd_1.0.49-1_amd64.deb

ADD start.sh /start.sh
ADD pureftpd-mysql.conf /etc/pureftpd-mysql.conf
ADD mysql.sql /mysql.sql
ADD pure-ftpd.pem /etc/ssl/private/pure-ftpd.pem

RUN chmod 600 /etc/ssl/private/pure-ftpd.pem \
    && chmod +x /start.sh \
    && adduser --shell /sbin/nologin --disabled-password ftpuser \
    && mkdir /dirs -p \
    && chown ftpuser:ftpuser /dirs/ -R

WORKDIR /

VOLUME ["/dirs/"]

EXPOSE 21

CMD ["/start.sh"]
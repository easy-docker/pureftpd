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
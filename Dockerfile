FROM ubuntu

LABEL maintainer="Ghostry <ghostry.green@gmail.com>"

RUN apt update && apt install -y openssl wget libmysqlclient-dev \
    && wget https://github.com/ghostry/docker-pureftpd/raw/master/pure-ftpd_1.0.49-1_amd64.deb \
    && dpkg -i ./pure-ftpd_1.0.49-1_amd64.deb \
    && rm -f ./pure-ftpd_1.0.49-1_amd64.deb \
    && apt-get autoremove -y wget \
    && dpkg -l|grep ^rc|awk '{print $2}'|xargs dpkg -P \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/*

ADD start.sh /start.sh
ADD pureftpd-mysql.conf /etc/pureftpd-mysql.conf
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
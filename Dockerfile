FROM centos as builder
WORKDIR /
RUN yum -y groupinstall 'Development Tools' \
    && yum -y install mariadb-devel wget
RUN wget https://download.pureftpd.org/pub/pure-ftpd/releases/pure-ftpd-1.0.49.tar.bz2 \
    && tar xvjpf pure-ftpd-1*.tar.bz2 \
    && cd pure-ftpd-1* \
    && ./configure --help \
    && ./configure --prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --libexecdir=/usr/libexec --datadir=/usr/share --sysconfdir=/etc --sharedstatedir=/usr/com --localstatedir=/var --libdir=/usr/lib64 --includedir=/usr/include --infodir=/usr/share/info --mandir=/usr/share/man --with-mysql --with-virtualchroot --with-tls --with-everything \
    && make

FROM alpine

LABEL maintainer="Ghostry <ghostry.green@gmail.com>"
RUN mkdir /usr/pureftpd
COPY --from=builder /pure-ftpd-1.0.49/src/pure-ftpd /usr/pureftpd/pure-ftpd
COPY --from=builder /pure-ftpd-1.0.49/src/ptracetest /usr/pureftpd/ptracetest
COPY --from=builder /pure-ftpd-1.0.49/src/pure-authd /usr/pureftpd/pure-authd
COPY --from=builder /pure-ftpd-1.0.49/src/pure-certd /usr/pureftpd/pure-certd
COPY --from=builder /pure-ftpd-1.0.49/src/pure-ftpwho /usr/pureftpd/pure-ftpwho
COPY --from=builder /pure-ftpd-1.0.49/src/pure-mrtginfo /usr/pureftpd/pure-mrtginfo
COPY --from=builder /pure-ftpd-1.0.49/src/pure-pw /usr/pureftpd/pure-pw
COPY --from=builder /pure-ftpd-1.0.49/src/pure-pwconvert /usr/pureftpd/pure-pwconvert
COPY --from=builder /pure-ftpd-1.0.49/src/pure-quotacheck /usr/pureftpd/pure-quotacheck
COPY --from=builder /pure-ftpd-1.0.49/src/pure-statsdecode /usr/pureftpd/pure-statsdecode
COPY --from=builder /pure-ftpd-1.0.49/src/pure-uploadscript /usr/pureftpd/pure-uploadscript

ADD start.sh /start.sh
ADD pure-ftpd /etc/conf.d/pure-ftpd
ADD pureftpd-mysql.conf /etc/pureftpd-mysql.conf
ADD mysql.sql /mysql.sql
ADD pure-ftpd.pem /etc/ssl/private/pure-ftpd.pem

RUN chmod +x /start.sh \
    && chmod -R 755 /usr/pureftpd \
    && chmod 600 /etc/ssl/private/pure-ftpd.pem \
    && adduser -s /sbin/nologin -D ftpuser \
    && mkdir /dirs -p \
    && chown ftpuser:ftpuser /dirs/ -R

WORKDIR /

VOLUME ["/dirs/"]

EXPOSE 21

CMD ["/start.sh"]
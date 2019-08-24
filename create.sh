#!/bin/sh
docker build -t pureftpd .
docker run --rm -it \
    --name pureftpd \
    -e MYSQLServer='172.17.0.1' \
    -e MYSQLPort=3306 \
    -e MYSQLUser='pureftpd' \
    -e MYSQLPassword='ye2C87tQ' \
    -p 21:21 \
    -p 30000-31000:30000-31000 \
    -v /www/gpanel/wwwroot:/dirs \
    pureftpd
# docker run --rm -it --name=pureftpd pureftpd
#docker exec -it pureftpd sh
#
/usr/pureftpd/pure-ftpd -S 23 -l mysql:/etc/pureftpd-mysql.conf -f /var/log/pureftpd.log -A -x -j -R -Z

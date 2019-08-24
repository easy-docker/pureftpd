#!/bin/sh
if [ -z $MYSQLServer ]; then
    MYSQLServer='172.17.0.1'
fi
if [ -z $MYSQLPort ]; then
    MYSQLPort=3306
fi
if [ -z $MYSQLUser ]; then
    MYSQLUser='pureftp'
fi
if [ -z $MYSQLPassword ]; then
    MYSQLPassword='pureftp'
fi
if [ -z $MYSQLDatabase ]; then
    MYSQLDatabase=$MYSQLUser
fi
al=`sed -n '/{{MYSQLServer}}/'p /etc/pureftpd-mysql.conf|wc -l`
if [ "$al" == "1" ]; then
    sed -i "s/{{MYSQLServer}}/$MYSQLServer/" /etc/pureftpd-mysql.conf
    sed -i "s/{{MYSQLPort}}/$MYSQLPort/" /etc/pureftpd-mysql.conf
    sed -i "s/{{MYSQLUser}}/$MYSQLUser/" /etc/pureftpd-mysql.conf
    sed -i "s/{{MYSQLPassword}}/$MYSQLPassword/" /etc/pureftpd-mysql.conf
    sed -i "s/{{MYSQLDatabase}}/$MYSQLDatabase/" /etc/pureftpd-mysql.conf
fi
while [[ true ]]; do
    sleep 3600
done
/usr/pureftpd/pure-ftpd -S 21 -l mysql:/etc/pureftpd-mysql.conf -f /var/log/pureftpd.log -A -x -j -R -Z
#!/bin/sh
docker build -t pureftpd .
docker run --rm -it \
    --name pureftpd \
    -e MYSQLServer='172.17.0.1' \
    -e MYSQLPort=3306 \
    -e MYSQLUser='pureftpd' \
    -e MYSQLPassword='PureFtpd5' \
    -e FTPParameter=" -d " \
    -p 21:21 \
    -p 30000-31000:30000-31000 \
    -v /www/gpanel/wwwroot:/dirs \
    pureftpd
exit;
FTPParameter="-S 21 \
    -l mysql:/etc/pureftpd-mysql.conf \
    -C 10 \
    -k 90 \
    -p 30000:31000 \
    -Y 1 -2 /etc/ssl/private/pure-ftpd.pem \
    -E -A -j -R -Z -H -w -D -d "
# docker run --rm -it --name=pureftpd pureftpd
docker exec -it pureftpd bash
#
pure-ftpd -S 23 \
    -l mysql:/etc/pureftpd-mysql.conf \
    -C 10 \
    -k 90 \
    -p 30000:31000 \
    -Y 1 -2 /etc/ssl/private/pure-ftpd.pem \
    -E -A -j -R -Z -H -w -D
pure-ftpd v1.0.49 [privsep]

-0  --notruncate
-1  --logpid
-2  --certfile  <opt> 公钥私钥文件
-3  --extcert   <opt>
-4  --ipv4only
-6  --ipv6only
-A  --chrooteveryone    都锁定到自己的home
-a  --trustedgid    <opt>
-b  --brokenclientscompatibility
-B  --daemonize
-C  --maxclientsperip   <opt> 最大ip链接
-c  --maxclientsnumber  <opt> 最大客户端链接
-d  --verboselog
-D  --displaydotfiles
-e  --anonymousonly
-E  --noanonymous   禁止游客登陆
-f  --syslogfacility    <opt>
-F  --fortunesfile  <opt>
-g  --pidfile   <opt>
-G  --norename
-h  --help
-H  --dontresolve   不要解析ip到域名
-I  --maxidletime   <opt>
-i  --anonymouscantupload
-j  --createhomedir home不存在时创建
-K  --keepallfiles
-k  --maxdiskusagepct   <opt> 最大磁盘用量百分比
-l  --login <opt>   用户引擎
-L  --limitrecursion    <opt>
-M  --anonymouscancreatedirs
-m  --maxload   <opt>
-N  --natmode
-n  --quota <opt>
-o  --uploadscript
-O  --altlog    <opt>
-p  --passiveportrange  <opt> 动态端口范围
-P  --forcepassiveip    <opt>
-q  --anonymousratio    <opt>
-Q  --userratio <opt>
-r  --autorename
-R  --nochmod
-s  --antiwarez
-S  --bind  <opt>
-t  --anonymousbandwidth    <opt>
-T  --userbandwidth <opt>
-U  --umask <opt>
-u  --minuid    <opt>
-V  --trustedip <opt>
-w  --allowuserfxp      为用户启用fxp
-W  --allowanonymousfxp
-x  --prohibitdotfileswrite
-X  --prohibitdotfilesread
-y  --peruserlimits <opt>
-Y  --tls   <opt>   启用tls 0不用,1可用,2必用
-J  --tlsciphersuite    <opt>
-z  --allowdotfiles
-Z  --customerproof

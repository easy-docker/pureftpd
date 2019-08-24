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
exit;
# docker run --rm -it --name=pureftpd pureftpd
docker exec -it pureftpd bash
#
/usr/local/sbin/pure-ftpd -S 23 \
    -l mysql:/etc/pureftpd-mysql.conf \
    -C 10 \
    -k 90 \
    -p 30000:31000 \
    -E -A -j -R -Z -H -w -D
pure-ftpd v1.0.49 [privsep]

-0  --notruncate
-1  --logpid
-2  --certfile  <opt>
-3  --extcert   <opt>
-4  --ipv4only
-6  --ipv6only
-A  --chrooteveryone
-a  --trustedgid    <opt>
-b  --brokenclientscompatibility
-B  --daemonize
-C  --maxclientsperip   <opt>
-c  --maxclientsnumber  <opt>
-d  --verboselog
-D  --displaydotfiles
-e  --anonymousonly
-E  --noanonymous
-f  --syslogfacility    <opt>
-F  --fortunesfile  <opt>
-g  --pidfile   <opt>
-G  --norename
-h  --help
-H  --dontresolve
-I  --maxidletime   <opt>
-i  --anonymouscantupload
-j  --createhomedir
-K  --keepallfiles
-k  --maxdiskusagepct   <opt>
-l  --login <opt>
-L  --limitrecursion    <opt>
-M  --anonymouscancreatedirs
-m  --maxload   <opt>
-N  --natmode
-n  --quota <opt>
-o  --uploadscript
-O  --altlog    <opt>
-p  --passiveportrange  <opt>
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
-w  --allowuserfxp
-W  --allowanonymousfxp
-x  --prohibitdotfileswrite
-X  --prohibitdotfilesread
-y  --peruserlimits <opt>
-Y  --tls   <opt>
-J  --tlsciphersuite    <opt>
-z  --allowdotfiles
-Z  --customerproof

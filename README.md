# docker-pureftpd
快速开始一个MySQL数据库的pureftpd
# 创建数据库
首先创建数据库,创建数据库用户,创建表
```
CREATE TABLE ftpd (
User varchar(16) NOT NULL default '',
status enum('0','1') NOT NULL default '0',
Password varchar(64) NOT NULL default '',
Uid varchar(11) NOT NULL default '-1',
Gid varchar(11) NOT NULL default '-1',
Dir varchar(128) NOT NULL default '',
ULBandwidth smallint(5) NOT NULL default '0',
DLBandwidth smallint(5) NOT NULL default '0',
comment tinytext NOT NULL,
ipaccess varchar(15) NOT NULL default '*',
QuotaSize smallint(5) NOT NULL default '0',
QuotaFiles int(11) NOT NULL default 0,
PRIMARY KEY (User),
UNIQUE KEY User (User)
) ENGINE=MyISAM;
```
# 测试
```
docker run --rm -it \
    --name pureftpd \
    -e MYSQLServer='172.17.0.1' \
    -e MYSQLPort=3306 \
    -e MYSQLUser='pureftp' \
    -e MYSQLPassword='pureftp' \
    -e MYSQLDatabase='pureftp' \
    -p 21:21 \
    -p 30000-31000:30000-31000 \
    -v dirs:/dirs \
    ghostry/pureftpd
```
# 部署
```
docker run -d --restart always \
    --name pureftpd \
    -e MYSQLServer='172.17.0.1' \
    -e MYSQLPort=3306 \
    -e MYSQLUser='pureftp' \
    -e MYSQLPassword='pureftp' \
    -e MYSQLDatabase='pureftp' \
    -p 21:21 \
    -p 30000-31000:30000-31000 \
    -v dirs:/dirs \
    ghostry/pureftpd
```

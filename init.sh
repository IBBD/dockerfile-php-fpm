#!/bin/bash
# 
# 初始化操作


# 初始化php的配置文件
[ ! -f run.sh ]             && cp run.sh.example run.sh
[ ! -f conf/php.ini ]       && cp conf/php.ini.example      conf/php.ini
[ ! -f conf/php-fpm.conf ]  && cp conf/php-fpm.conf.example conf/php-fpm.conf 

# 下载相关文件
#source ./download.sh 

echo '==> php-fpm init ok'


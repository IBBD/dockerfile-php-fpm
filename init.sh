#!/bin/bash
# 
# 初始化操作


# 初始化php的配置文件
cp run.sh.example run.sh
cp conf/php-fpm.conf.example conf/php-fpm.conf 
cp conf/php.ini.example      conf/php.ini

# 下载相关文件
source ./download.sh 

echo '==> php-fpm init ok'


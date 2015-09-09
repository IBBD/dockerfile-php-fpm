#!/bin/bash

# 下载（更新）必要的组件
# 在build之前执行，定时更新即可

if [ ! -d ext ]
then
    mkdir ext 
fi

cd ext

# sources.list
rm sources.list
wget https://raw.githubusercontent.com/IBBD/docker-compose/master/sources.list/debian/sources.list -O sources.list

# redis 
rm redis.tgz
wget http://pecl.php.net/get/redis -O redis.tgz

# mongo
rm mongo.tgz
wget http://pecl.php.net/get/mongo -O mongo.tgz

# msgpack
rm msgpack.tgz
wget http://pecl.php.net/get/msgpack -O msgpack.tgz

# memcache
# 缓存虽然我们用redis，不过有些地方可能需要memcache扩展
rm memcache.tgz
wget http://pecl.php.net/get/memcache -O memcache.tgz

# composer
echo 'begin get composer.php...'
curl -sS https://getcomposer.org/installer -o composer.php
echo 'end of composer.php'

echo "===> Finish!"


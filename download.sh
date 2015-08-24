#!/bin/bash

if [ ! -d ext ]
then
    mkdir ext 
fi

# copy 
cp ../docker-compose/sources.list/debian/sources.list ext

cd ext

# redis 
rm redis.tgz
wget http://pecl.php.net/get/redis -O redis.tgz

# mongo
rm mongo.tgz
wget http://pecl.php.net/get/mongo -O mongo.tgz

# msgpack
rm msgpack.tgz
wget http://pecl.php.net/get/msgpack -O msgpack.tgz

echo "===> Finish!"

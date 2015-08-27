#!/bin/bash
# 需要重启nginx
# 


docker stop ibbd-php-fpm 
docker rm ibbd-php-fpm 

docker run --name=ibbd-php-fpm -d \
    -p 9000:9000 \
    -v /home/code/ibbd:/var/www \
    -v /var/log/php:/var/log/php \
    ibbd/php-fpm

docker ps

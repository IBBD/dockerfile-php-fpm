#!/bin/bash
# 

name=php-dev
sudo docker stop ibbd-$name
sudo docker rm ibbd-$name

sudo docker --debug run -ti --name ibbd-$name -d \
    -p 9000:9000 \
    -v /var/www:/var/www \
    ibbd/$name \
    php-fpm -c /usr/local/etc/php/php.ini -y /usr/local/etc/php-fpm.conf
    #/bin/bash


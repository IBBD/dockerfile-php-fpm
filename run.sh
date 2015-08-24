#!/bin/bash
# 需要重启nginx
# 


docker stop ibbd-php 
docker rm ibbd-php 

docker run --name=ibbd-php -d \
    -p 9000:9000 \
    -v /home/code/ibbd:/var/www/html \
    ibbd/php


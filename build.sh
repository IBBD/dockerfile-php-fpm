#!/bin/bash

# 清除已有的
docker stop ibbd-php-fpm
docker rm ibbd-php-fpm 
docker rmi ibbd/php-fpm 

# 重新生成
docker build -t ibbd/php-fpm ./


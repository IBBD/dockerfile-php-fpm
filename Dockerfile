#
# PHP Dockerfile
# 满足laravel5.1版本的基本要求
#
# https://github.com/ibbd/dockerfile-php-fpm
#
# 下载相关资源：./download.sh
# sudo docker build -t ibbd/php ./
#

# Pull base image.
#FROM php:5.6
FROM php:5.6-fpm

# sources.list
# git clone git@github.com:IBBD/docker-compose.git
ADD ext/sources.list   /etc/apt/sources.list

# Install modules
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libssl-dev \
    && rm -r /var/lib/apt/lists/*

# install php modules
RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install iconv mcrypt pdo tokenizer mbstring

# PHP config
ADD conf/php.ini        /usr/local/etc/php/php.ini
ADD conf/php-fpm.conf   /usr/local/etc/php-fpm.conf

# pecl install php modules
RUN  mkdir /home/php
COPY ext/redis.tgz    /home/php/redis.tgz 
COPY ext/mongo.tgz    /home/php/mongo.tgz 
COPY ext/msgpack.tgz  /home/php/msgpack.tgz 

# 安装mongo扩展时，出现如下错误：
# Unable to load dynamic library '/usr/local/lib/php/extensions/no-debug-non-zts-20131226/mongo.so'
# 需要先安装libssl-dev
RUN cd /home/php \
    && pecl install redis.tgz \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install msgpack.tgz \
    && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
    && pecl install mongo.tgz \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
    #&& pecl install swoole \
    #&& echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini \
    && rm -rf /home/php

# composer 
#RUN curl -sS https://getcomposer.org/installer | php \
    #&& mv composer.phar /usr/local/bin/composer \
    #&& chmod 755 /usr/local/bin/composer
# composer中国镜像
#RUN composer config -g repositories.packagist composer http://packagist.phpcomposer.com

WORKDIR /var/www 

# Define mountable directories.
VOLUME ["/var/log/php", "/var/www"]

EXPOSE 9000
#CMD ["php-fpm"]


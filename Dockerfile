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

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# sources.list
# git clone git@github.com:IBBD/docker-compose.git
# 如果导致apt-get Install不成功，可以先注释这句
ADD ext/sources.list   /etc/apt/sources.list

# Install modules
RUN apt-get update 
RUN apt-get install -y \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libssl-dev \
    && rm -r /var/lib/apt/lists/*

# install php modules
# composer需要先安装zip
RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install iconv mcrypt pdo pdo_mysql tokenizer mbstring zip

# PHP config
#ADD conf/php.ini        /usr/local/etc/php/php.ini
#ADD conf/php-fpm.conf   /usr/local/etc/php-fpm.conf

# pecl install php modules
RUN  mkdir /home/php
#COPY ext/redis.tgz    /home/php/redis.tgz 
#COPY ext/mongo.tgz    /home/php/mongo.tgz 
COPY ext/msgpack.tgz  /home/php/msgpack.tgz 
#COPY ext/memcache.tgz /home/php/memcache.tgz 

# 安装mongo扩展时，出现如下错误：
# Unable to load dynamic library '/usr/local/lib/php/extensions/no-debug-non-zts-20131226/mongo.so'
# 需要先安装libssl-dev
# 如果本地构建的话，建议先下载好相应的扩展包
# 直接使用pecl install msgpack会报错：
# Failed to download pecl/msgpack within preferred state "stable", latest release is version 0.5.7, stability "beta", use "channel://pecl.php.net/msgpack-0.5.7" to install
#
RUN cd /home/php \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install memcache \
    && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini \
    && pecl install msgpack.tgz \
    && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
    && pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
    && pecl install swoole \
    && echo "extension=swoole.so" > /usr/local/etc/php/conf.d/swoole.ini \
    && pecl install xdebug \
    && echo "extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini 

# composer 
# composer中国镜像
# phpunit
COPY ext/composer.php /home/php/composer.php
COPY ext/phpunit.phar /home/php/phpunit.phar
RUN php /home/php/composer.php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod 755 /usr/local/bin/composer \
    && composer config -g repositories.packagist composer http://packagist.phpcomposer.com \
    && chmod +x /hom/php/phpunit.phar \
    && mv /home/php/phpunit.phar /usr/local/bin/phpunit \
    && phpunit --version \
    && rm -rf /home/php \


WORKDIR /var/www 

# 解决时区问题
env TZ "Asia/Shanghai"

# Define mountable directories.
VOLUME /var/www

EXPOSE 9000
#CMD ["php-fpm"]


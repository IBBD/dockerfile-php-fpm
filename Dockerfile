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
# composer需要先安装zip
RUN \
    apt-get update \
    && apt-get install -y \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libssl-dev \
    && rm -r /var/lib/apt/lists/*


COPY ext/msgpack.tgz  /msgpack.tgz 
COPY ext/composer.php /composer.php

# install php modules
# pecl install php modules
# 安装mongo扩展时，出现如下错误：
# Unable to load dynamic library '/usr/local/lib/php/extensions/no-debug-non-zts-20131226/mongo.so'
# 需要先安装libssl-dev
# 如果本地构建的话，建议先下载好相应的扩展包
# 直接使用pecl install msgpack会报错：
# Failed to download pecl/msgpack within preferred state "stable", latest release is version 0.5.7, stability "beta", use "channel://pecl.php.net/msgpack-0.5.7" to install
# composer 
# composer中国镜像
RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install iconv mcrypt pdo pdo_mysql tokenizer mbstring zip \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install memcache \
    && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini \
    && pecl install /msgpack.tgz \
    && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
    && rm /msgpack.tgz \
    && pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
    && cd / \
    && php /composer.php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod 755 /usr/local/bin/composer \
    && rm /composer.php \
    && composer config -g repositories.packagist composer http://packagist.phpcomposer.com 


# 工作目录
WORKDIR /var/www 

# 解决时区问题
env TZ "Asia/Shanghai"

# Define mountable directories.
VOLUME /var/www

EXPOSE 9000
#CMD ["php-fpm"]


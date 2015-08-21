#
# PHP Dockerfile
# 满足laravel5.1版本的基本要求
#
# https://github.com/ibbd/dockerfile-php
#
# sudo docker build -t ibbd/php ./
#

# Pull base image.
#FROM php:5.6
FROM php:5.6-fpm

# Install modules
RUN apt-get update && apt-get install -y \
        libmcrypt-dev \
    && docker-php-ext-install iconv mcrypt pdo tokenizer

CMD ["php-fpm"]


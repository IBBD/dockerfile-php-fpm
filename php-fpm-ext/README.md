# PHP FPM 镜像 For Laravel and Lumen

扩展镜像，主要满足产品项目的特殊需要，基于`ibbd/php-fpm`

## php5.6-fpm镜像体系

- `php5.6-fpm`: 这是基础镜像
- `ibbd/php-fpm`：用于生产环境。没有多余的插件，包括过时的插件（如mysql）和多余的插件（例如gd等）
- `ibbd/php-fpm-ext`: 用于生产环境, 基于`ibbd/php-fpm`。包含一些项目可能需要用到的插件（例如mysql，gd等）
- `ibbd/php-fpm-dev`: 用于测试环境及本地。在`ibbd/php-fpm-ext`的基础上包含一些测试工具等

## 更新记录

## PHP扩展 

iconv, pdo, tokenizer, mbstring: 已经包含在基础镜像里

- gd
- mcrypt
- redis
- mongo（已经不需要了）
- mongodb
- msgpack 
- zip
- mysqli
- imagick
- mysql（有些旧代码居然还用这个！）

附加安装

- composer（全局安装）
- Laravel Installer: 文档https://laravel.com/docs/
- Lumen Installer: 文档https://lumen.laravel.com/docs/

## 安装 

- Dockerfile: `sudo ./build.sh`
- Pull: `sudo docker pull ibbd/php-fpm-ext`

## 使用

```sh
# 代码目录
code_path=/var/www

# 日志目录
logs_path=/var/log/php

conf_path=$(pwd)
conf_path=${conf_path%/*}
docker run --name=ibbd-php-fpm -d \
    -p 9000:9000 \
    -v $code_path:/var/www \
    -v $logs_path:/var/log/php \
    -v $conf_path/conf/php.ini:/usr/local/etc/php/php.ini:ro \
    -v $conf_path/conf/php-fpm.conf:/usr/local/etc/php-fpm.conf:ro \
    ibbd/php-fpm-ext \
    php-fpm -c /usr/local/etc/php/php.ini -y /usr/local/etc/php-fpm.conf
```

# PHP FPM 镜像 For Laravel and Lumen

## php5.6-fpm镜像体系

- `php5.6-fpm`: 这是基础镜像
- `ibbd/php-fpm`：用于生产环境。没有多余的插件，包括过时的插件（如mysql）和多余的插件（例如gd等）
- `ibbd/php-fpm-ext`: 用于生产环境, 基于`ibbd/php-fpm`。包含一些项目可能需要用到的插件（例如mysql，gd等）
- `ibbd/php-fpm-dev`: 用于测试环境及本地。在`ibbd/php-fpm-ext`的基础上包含一些测试工具等

## 更新记录

2017.07.28

回退到5.6.21,这个版本才支持生意经项目

2017.04.28

更新到5.6.30

2016.06.28

更新到5.6.23

2016.05.25

镜像结构体系调整，把`ibbd/php-fpm`镜像分拆成了基础镜像`ibbd/php-fpm`和扩展镜像`ibbd/php-fpm-ext`

2016.05.03

- php升级到5.6.21

2016.03.18

- 增加mongodb插件

2016.03.09

- php版本升级到5.6.19
- 增加mysql扩展（有些变态的框架还在用这个扩展）

2016.02.26

更改composer的安装方式，去掉packagist的国内镜像（可能用到国外服务器，而且也不稳定）

2016.02.26

php版本更新到5.6.18

2016.01.22

php版本更新到5.6.17

## 基础说明

该镜像主要为满足 `laravel5` 框架而制作，并附加了 `redis`, `mongodb`, `msgpack`等扩展。

说明：

- 基础镜像：[php-fpm](https://hub.docker.com/_/php)
- 如果需要扩展功能，请使用`ibbd/php-fpm-ext`
- 如果需要phpunit，xdebug，pman等测试及开发工具，请使用`ibbd/php-fpm-dev`镜像，对应的dockerfile在目录`php-fpm-dev`下。
- 如果只是使用php的命令行，可以使用对应的cli镜像（含swoole）：`ibbd/php-cli`和`ibbd-cli-dev`

## PHP扩展 

- mcrypt
- redis
- mongodb
- msgpack 
- zip

附加安装

- composer（全局安装）
- Laravel Installer: 文档https://laravel.com/docs/
- Lumen Installer: 文档https://lumen.laravel.com/docs/

## 安装 

- Dockerfile: `sudo ./build.sh`
- Pull: `sudo docker pull ibbd/php-fpm`

## 使用

```sh
# 代码目录
code_path=/var/www

# 日志目录
logs_path=/var/log/php

current_path=$(pwd)
docker run --name=ibbd-php-fpm -d \
    -p 9000:9000 \
    -v $code_path:/var/www \
    -v $logs_path:/var/log/php \
    -v $current_path/conf/php.ini:/usr/local/etc/php/php.ini:ro \
    -v $current_path/conf/php-fpm.conf:/usr/local/etc/php-fpm.conf:ro \
    ibbd/php-fpm \
    php-fpm -c /usr/local/etc/php/php.ini -y /usr/local/etc/php-fpm.conf
```

说明：完整的应用见 `./run.sh.example`


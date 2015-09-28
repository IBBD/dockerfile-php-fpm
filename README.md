# PHP FPM Dockerfile

该镜像主要为满足 `laravel5` 框架而制作，并附加了 `redis`, `mongo`, `msgpack`, `swoole`等扩展。

如果需要phpunit，xdebug，pman等测试及开发工具，请使用`ibbd/php-dev`镜像，对应的dockerfile在目录`php-dev`下。

## 基础说明

- 基础镜像：php-fpm:5.6
- 使用了阿里云的更新源，见 `./ext/sources.list`

## PHP扩展 

- iconv 
- mcrypt
- pdo
- tokenizer 
- mbstring 
- gd 
- redis
- mongo
- msgpack 
- swoole 
- zip

附加安装

- php composer

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


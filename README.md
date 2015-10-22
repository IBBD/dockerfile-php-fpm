# PHP FPM 镜像

该镜像主要为满足 `laravel5.1` 框架而制作，并附加了 `redis`, `mongo`, `msgpack`, `imagick`等扩展。

说明：

- 如果需要phpunit，xdebug，pman等测试及开发工具，请使用`ibbd/php-fpm-dev`镜像，对应的dockerfile在目录`php-fpm-dev`下。
- 如果只是使用php的命令行，可以使用对应的cli镜像（含swoole）：`ibbd/php-cli`和`ibbd-cli-dev`

## 基础说明

- 基础镜像：php-fpm:5.6
- 使用了阿里云的更新源，见 `./ext/sources.list`

## PHP扩展 

- gd
- iconv 
- mcrypt
- pdo
- tokenizer 
- mbstring 
- gd 
- redis
- mongo
- msgpack 
- zip
- mysqli
- imagick

附加安装

- composer（使用国内镜像）

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


#!/bin/bash

name=php-dev

# 清除已有的
sudo docker stop ibbd-$name
sudo docker rm ibbd-$name
sudo docker rmi ibbd/$name

# 重新生成
sudo docker build -t ibbd/$name ./


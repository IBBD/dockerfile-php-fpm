#!/bin/bash

# 清除已有的
docker stop ibbd-php 
docker rm ibbd-php 
docker rmi ibbd/php 

# 重新生成
docker build -t ibbd/php ./


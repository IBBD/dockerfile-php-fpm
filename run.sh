#!/bin/bash

docker stop ibbd-php 
docker rm ibbd-php 

docker run -ti --rm --name ibbd-php  \
    -p 9000:9000 \
    ibbd/php

docker ps -a

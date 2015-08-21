#!/bin/bash

docker stop ibbd-php
docker rm ibbd-php

docker --debug=true run --name ibbd-php -d -p 80:80 ibbd/php
#docker --debug=true run --name ibbd-php -d -p 80:80 -v /usr/local/php/conf/vhost:/etc/php/sites-enabled -v /var/log/php:/var/log/php -v /home/code/ibbd:/var/www/html ibbd/php

docker ps -a

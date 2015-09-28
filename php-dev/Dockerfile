#
# PHP Dev Dockerfile
# 在ibbd/php-fpm的基础上安装开发环境
#
# https://github.com/ibbd/dockerfile-php-dev
#
# sudo docker build -t ibbd/php-dev ./
#

# Pull base image.
FROM ibbd/php-fpm

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

WORKDIR /var/www

# 安装公共开发工具的工具
RUN apt-get update \
    && apt-get install -y \
        man \
        git-core \
        vim-tiny \
    && echo "set fileencodings=utf-8" >> /etc/vim/vimrc \
    && echo "set fileencoding=utf-8" >> /etc/vim/vimrc \
    && echo "set encoding=utf-8" >> /etc/vim/vimrc \
    && git config --global push.default simple \
    && rm -r /var/lib/apt/lists/*

# 安装pman 
# 安装之后用不了，囧
RUN pear install doc.php.net/pman \
    && pear upgrade pear 

# 终端设置
# 执行php-fpm时，默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm


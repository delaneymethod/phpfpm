FROM ubuntu:16.04

MAINTAINER Sean Delaney <hello@delaneymethod.com>

RUN apt-get update && apt-get install -y locales && locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN apt-get update && apt-get install -y jpegoptim optipng pngquant gifsicle curl zip unzip git software-properties-common && add-apt-repository -y ppa:ondrej/php && apt-get update && apt-get install -y php7.2-fpm php7.2-cli php7.2-common php7.2-gd php7.2-mysql php7.2-pgsql php7.2-sqlite php7.2-sqlite3 php7.2-imap php7.2-memcached php7.2-mbstring php7.2-imagick php7.2-xml php7.2-zip php7.2-curl php7.2-xdebug php7.2-bcmath && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer && mkdir /run/php && apt-get remove -y --purge software-properties-common && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf

COPY www.conf /etc/php/7.2/fpm/pool.d/www.conf

COPY php.ini /etc/php/7.2/fpm/php.ini

COPY xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

EXPOSE 9000

CMD ["php-fpm7.2"]

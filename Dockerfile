FROM ubuntu:18.04

MAINTAINER Sean Delaney <hello@delaneymethod.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales && locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y jpegoptim optipng pngquant gifsicle curl zip unzip git software-properties-common && add-apt-repository -y ppa:ondrej/php && apt-get update && apt-get install -y php7.3-bcmath php7.3-fpm php7.3-cli php7.3-common php7.3-gd php7.3-mysql php7.3-pgsql php7.3-sqlite php7.3-sqlite3 php7.3-imap php7.3-memcached php7.3-mbstring php7.3-imagick php7.3-xml php7.3-zip php7.3-curl php7.3-xdebug php7.3-bcmath && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer && mkdir /run/php && apt-get remove -y --purge software-properties-common && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY php.ini /etc/php/7.3/fpm/php.ini

COPY xdebug.ini /etc/php/7.3/mods-available/xdebug.ini

EXPOSE 9000

CMD ["php-fpm7.3"]

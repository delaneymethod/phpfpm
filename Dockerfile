FROM ubuntu:21.04

MAINTAINER Sean Delaney <hello@delaneymethod.com>

ENV TZ Europe/London
ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y locales && locale-gen $LANG

RUN apt-get update && apt-get install -y jpegoptim optipng pngquant gifsicle curl zip unzip git software-properties-common && add-apt-repository -y ppa:ondrej/php && apt-get update && apt-get install -y php7.4-bcmath php7.4-fpm php7.4-cli php7.4-common php7.4-intl php7.4-gd php7.4-mysql php7.4-pgsql php7.4-sqlite php7.4-sqlite3 php7.4-imap php7.4-memcached php7.4-mbstring php7.4-imagick php7.4-xml php7.4-zip php7.4-curl php7.4-xdebug php7.4-bcmath && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer && mkdir /run/php && apt-get remove -y --purge software-properties-common && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY php.ini /etc/php/7.4/fpm/php.ini

COPY xdebug.ini /etc/php/7.4/mods-available/xdebug.ini

EXPOSE 9000

CMD ["php-fpm7.4"]

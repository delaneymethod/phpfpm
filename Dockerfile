FROM ubuntu:16.04

MAINTAINER Sean Delaney

RUN apt-get update && apt-get install -y locales && locale-gen en_GB.UTF-8

ENV LANG en_GB.UTF-8
ENV LANGUAGE en_GB:en
ENV LC_ALL en_GB.UTF-8

RUN apt-get update && apt-get install -y curl zip unzip git software-properties-common && add-apt-repository -y ppa:ondrej/php && apt-get update && apt-get install -y php7.1-fpm php7.1-cli php7.1-mcrypt php7.1-gd php7.1-mysql php7.1-pgsql php7.1-imap php7.1-memcached php7.1-mbstring php7.1-imagick php7.1-xml php7.1-zip php7.1-curl && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer && mkdir /run/php && apt-get remove -y --purge software-properties-common && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf

ADD www.conf /etc/php/7.1/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.1"]
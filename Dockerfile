FROM ubuntu:trusty

# https://github.com/digitalmethodsinitiative/dmi-tcat/wiki/Installation-Guide#manual-installation

RUN apt-get clean && apt-get -q -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get -q -y --fix-missing install \
    apache2 \
    apache2-utils \
    build-essential \
    git \
    libapache2-mod-php5 \
    libevent-dev \
    mariadb-client-5.5 \
    openssh-server \
    openssl \
    php-patchwork-utf8 \
    php5-cli \
    php5-dev \
    php5-mysql php5-curl \
    phpunit \
    python-all-dev \
    python-mysqldb \
    python-pip \
    python-setuptools \  
    supervisor \
    wget
    
RUN easy_install greenlet
RUN easy_install gevent 
RUN sudo pip install requests 

# http://www.saintsjd.com/2014/06/05/howto-intsall-libgeos-with-php5-bindings-ubuntu-trusty-14.04.html
RUN wget http://download.osgeo.org/geos/geos-3.4.2.tar.bz2
RUN tar -xjvf geos-3.4.2.tar.bz2
WORKDIR /geos-3.4.2
RUN ./configure --enable-php
RUN make
RUN make install

WORKDIR /var/www/html
RUN git clone --depth 1 https://github.com/digitalmethodsinitiative/dmi-tcat.git
RUN chown -R www-data dmi-tcat
RUN mkdir dmi-tcat/analysis/cache; chown www-data dmi-tcat/analysis/cache; chmod 755 dmi-tcat/analysis/cache;
RUN mkdir dmi-tcat/logs; chown www-data dmi-tcat/logs; chmod 755 dmi-tcat/logs;
RUN mkdir dmi-tcat/proc; chown www-data dmi-tcat/proc; chmod 755 dmi-tcat/proc;
WORKDIR /

COPY geos.ini /etc/php5/mods-available/geos.ini
RUN php5enmod geos
RUN echo "<?php phpinfo(); ?>" >> /var/www/html/info.php
RUN echo "<?php echo GEOSVersion(); ?>" >> /var/www/html/geostest.php

RUN echo "* * * * * www-data (cd /var/www/html/dmi-tcat/capture/stream/; php controller.php)" >> /etc/cron.d/tcat
RUN echo "0 * * * * www-data (cd /var/www/html/dmi-tcat; sh urlexpand.sh)" >> /etc/cron.d/tcat

COPY config.php /var/www/html/dmi-tcat/config.php
COPY apache.conf /etc/apache2/sites-available/000-default.conf
COPY tcat_db.sql /tcat_db.sql
COPY init_db.sh /init_db.sh
COPY apache_pw.sh /apache_pw.sh

COPY index.html /var/www/html/index.html

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord"]


FROM php:7.4-apache

LABEL maintainer "raelsoncr@gmail.com"

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN a2enmod rewrite

RUN apt-get update -y && apt-get install -y \
    libpng-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libwebp-dev \
    libjpeg62-turbo-dev \
    unzip \
    libonig-dev \
    libzip-dev \
    curl \
    libmcrypt-dev \
    libjpeg-dev \
    libbz2-dev \
    libc-client-dev \
    libkrb5-dev \
    libmagickwand-dev --no-install-recommends \
    cron

RUN pecl install imagick redis xdebug

RUN docker-php-ext-enable imagick redis xdebug

RUN docker-php-ext-install zip mbstring pdo_mysql opcache mysqli bcmath exif

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

RUN  apt-get install build-essential zlib1g-dev -y
RUN  apt-get install wget openssl -y

# php composer-setup.php --version=1.10.16

RUN echo "---> Installing Composer" && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    echo "---> Cleaning up" && \
    rm -rf /tmp/* && \
    composer -V

# RUN composer global require hirak/prestissimo && \
RUN composer global require \
    #php-parallel-lint/php-parallel-lint \
    #php-parallel-lint/php-console-highlighter \
    #jakub-onderka/php-var-dump-check \
    phpunit/phpunit phpunit/phpcov \
    phpmd/phpmd squizlabs/php_codesniffer \
    symfony/phpunit-bridge \
    laravel/envoy \
    phpstan/phpstan && \
    #nunomaduro/phpinsights && \
    # ln -sn /root/.composer/vendor/bin/parallel-lint /usr/local/bin/parallel-lint && \
    #ln -sn /root/.composer/vendor/bin/php-parallel-lint /usr/local/bin/php-parallel-lint && \
    #ln -sn /root/.composer/vendor/bin/var-dump-check /usr/local/bin/var-dump-check && \
    ln -sn /root/.composer/vendor/bin/phpunit /usr/local/bin/phpunit && \
    ln -sn /root/.composer/vendor/bin/phpcov /usr/local/bin/phpcov && \
    ln -sn /root/.composer/vendor/bin/phpmd /usr/local/bin/phpmd && \
    ln -sn /root/.composer/vendor/bin/phpcs /usr/local/bin/phpcs && \
    ln -sn /root/.composer/vendor/bin/phpunit-bridge /usr/local/bin/phpunit-bridge && \
    ln -sn /root/.composer/vendor/bin/envoy /usr/local/bin/envoy && \
    ln -sn /root/.composer/vendor/bin/phpstan /usr/local/bin/phpstan && \
    wget https://phar.phpunit.de/phpcpd.phar && \
    mv phpcpd.phar /usr/local/bin/phpcpd && \
    chmod +x /usr/local/bin/phpcpd

RUN wget https://github.com/phpDocumentor/phpDocumentor2/releases/download/v2.9.0/phpDocumentor.phar
RUN echo -e "#!/bin/bash\n\nphp /phpDocumentor.phar \$@" >> /usr/local/bin/phpdoc && \
    chmod +x /usr/local/bin/phpdoc

RUN phpunit --version && \
    phpcov --version && \
    phpcs --version && \
    phpcpd --version

RUN echo "Install NODE" && \
    curl -fsSL https://fnm.vercel.app/install | bash && \
    echo "12.20.1" >> .node-version && \
    eval "$(/root/.fnm/fnm env)" && \
    /root/.fnm/fnm install



# Add crontab file in the cron directory
ADD scheduler /etc/cron.d/scheduler

# Run the cron
RUN crontab /etc/cron.d/scheduler


RUN usermod -u 1000 www-data
USER www-data
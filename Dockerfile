# Basis PHP + Apache
FROM php:8.2-apache

# Laravel vereisten
RUN apt-get update && apt-get install -y \
    git unzip libzip-dev libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Composer installeren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Apache mod_rewrite aanzetten
RUN a2enmod rewrite

# Stel Laravel public folder als document root in
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!/var/www/html/public!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


# Werkdirectory
WORKDIR /var/www/html

# Poort openen
EXPOSE 80

CMD ["apache2-foreground"]

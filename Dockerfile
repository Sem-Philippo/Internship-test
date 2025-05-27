FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git curl libzip-dev unzip libpng-dev libonig-dev zip libxml2-dev libssl-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy Laravel app
COPY ./API /var/www

# Install Laravel dependencies
RUN composer install

# Fix permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Modify PHP-FPM to listen on all interfaces
RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /usr/local/etc/php-fpm.d/www.conf
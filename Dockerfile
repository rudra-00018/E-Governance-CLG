FROM php:8.2-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install PHP extensions needed for MySQL
RUN docker-php-ext-install pdo pdo_mysql mysqli

# Set working directory
WORKDIR /var/www/html

# Copy all project files
COPY . .

# Set Apache DocumentRoot to project root so index.php is served
RUN echo '<Directory /var/www/html>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-enabled/override.conf

# Expose port (Railway sets PORT env var)
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]

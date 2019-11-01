FROM php:7

# Setup nodejs install
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

# Install deps
RUN apt-get update -y && apt-get install -y openssl zip unzip git libpng-dev nodejs

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add vulnerable php libs
WORKDIR /app
COPY . /app
RUN composer install

# Add vulnerable node packages as well as non vulnerable packages
RUN npm install -g apostrophe@2.89.1 https-proxy-agent@2.2.2 async handlebars request

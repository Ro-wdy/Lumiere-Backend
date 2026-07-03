#!/bin/sh
set -e

# Ensure storage directories exist and are writable
mkdir -p /var/www/html/storage/framework/cache
mkdir -p /var/www/html/storage/framework/sessions
mkdir -p /var/www/html/storage/framework/views
mkdir -p /var/www/html/storage/logs
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Ensure persistent database directory exists
mkdir -p /var/data
touch /var/data/database.sqlite
chown -R www-data:www-data /var/data

# Run migrations
php artisan migrate --force

# Seed database if there are no films
count=$(sqlite3 /var/data/database.sqlite "SELECT count(*) FROM films;" 2>/dev/null || echo "0")
if [ "$count" = "0" ] || [ -z "$count" ]; then
    echo "No films found. Seeding database..."
    php artisan db:seed --force
else
    echo "Database already seeded. Skipping seeder."
fi

exec "$@"

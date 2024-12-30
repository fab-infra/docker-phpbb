# PHP 8.2 base image
FROM ghcr.io/fab-infra/php-apache:8.2-opensuse15

# Arguments
ARG PHPBB_VERSION="3.3.14"
ARG PHPBB_URL="https://download.phpbb.com/pub/release/3.3/${PHPBB_VERSION}/phpBB-${PHPBB_VERSION}.tar.bz2"

# Download and extract phpBB
RUN curl -sSLf -o "/tmp/phpBB.tar.bz2" "${PHPBB_URL}" &&\
    mkdir -p "/srv/www/apps" &&\
    tar -xf "/tmp/phpBB.tar.bz2" -C "/srv/www/apps" &&\
    mv "/srv/www/apps/phpBB3" "/srv/www/apps/phpbb" &&\
    mkdir -p "/srv/www/apps/phpbb/cache/production" &&\
    chown -R wwwrun:www "/srv/www/apps/phpbb" &&\
    chmod a+rwX "/srv/www/apps/phpbb" &&\
    chmod -R a+rwX /srv/www/apps/phpbb/{cache,config.php,files,images,install,store} &&\
    rm -f "/tmp/phpBB.tar.bz2"

# Work directory
WORKDIR /srv/www/apps/phpbb

# Environment
ENV DEFAULT_DOCROOT="/srv/www/apps/phpbb" \
    PHPBB_COOKIE_SECURE="false" \
    PHPBB_DATABASE_HOST="mariadb" \
    PHPBB_DATABASE_NAME="phpbb" \
    PHPBB_DATABASE_PASSWORD="" \
    PHPBB_DATABASE_PORT_NUMBER="3306" \
    PHPBB_DATABASE_USER="phpbb" \
    PHPBB_DISABLE_SESSION_VALIDATION="false" \
    PHPBB_EMAIL="admin@example.org" \
    PHPBB_EXTENSIONS="phpbb/viglink" \
    PHPBB_FORUM_DESCRIPTION="A little text to describe your forum" \
    PHPBB_FORUM_LANGUAGE="en" \
    PHPBB_FORUM_NAME="My forum" \
    PHPBB_FORUM_SERVER_PORT="80" \
    PHPBB_FORUM_SERVER_PROTOCOL="http://" \
    PHPBB_HOST="localhost" \
    PHPBB_PASSWORD="adminadmin" \
    PHPBB_SKIP_BOOTSTRAP="false" \
    PHPBB_SMTP_HOST="" \
    PHPBB_SMTP_PASSWORD="" \
    PHPBB_SMTP_PORT_NUMBER="" \
    PHPBB_SMTP_PROTOCOL="" \
    PHPBB_SMTP_PROTOCOL="plain" \
    PHPBB_SMTP_USER="" \
    PHPBB_USERNAME="admin"

# Files
COPY ./root /

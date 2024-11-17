[![build](https://github.com/fab-infra/docker-phpbb/actions/workflows/build.yml/badge.svg)](https://github.com/fab-infra/docker-phpbb/actions/workflows/build.yml)

# phpBB Docker image

## Ports

The following ports are exposed by this container image.

| Port | Description |
| ---- | ----------- |
| 8080 | HTTP port |
| 8443 | HTTPS port |

## Environment variables

The following environment variables can be used with this container.

| Variable | Description | Default value |
| -------- | ----------- | ------------- |
| APACHE_MPM | Multi-Processing Module (prefork, worker, event) | prefork |
| APACHE_MODULES | Modules to enable (space-separated) | (see Dockerfile) |
| APACHE_SERVER_FLAGS | Flags to enable (space-separated) | |
| APACHE_ACCESS_LOG | Access log location and format | /dev/stdout combined |
| APACHE_ERROR_LOG | Error log location | /dev/stderr |
| SERVER_NAME | Server host name | localhost |
| SERVER_ENV | Server environment | production |
| DEFAULT_DOCROOT | Document root of the default virtual host | /srv/www/htdocs |
| LISTEN_HTTP_PORT | HTTP port to listen to | 8080 |
| LISTEN_HTTPS_PORT | HTTPS port to listen to | 8443 |
| PHP_DATE_TIMEZONE | PHP timezone | Europe/Paris |
| PHP_ENABLE_OPCACHE | Enables OPcache for PHP scripts | 1 |
| PHP_MAX_EXECUTION_TIME | Maximum execution time for PHP scripts | 3600 |
| PHP_MAX_INPUT_TIME | Maximum input time for PHP scripts | 3600 |
| PHP_MAX_INPUT_VARS | Maximum amount of input variables for PHP scripts | 1000 |
| PHP_MEMORY_LIMIT | Memory limit for PHP scripts | 4G |
| PHP_POST_MAX_SIZE | Maximum size for PHP POST requests | 4G |
| PHP_UPLOAD_MAX_FILESIZE | Maximum file size for PHP uploads | 4G |
| PHPBB_COOKIE_SECURE | Use secure cookies | false |
| PHPBB_DATABASE_HOST | Database server host | mariadb |
| PHPBB_DATABASE_NAME | Database name | phpbb |
| PHPBB_DATABASE_PASSWORD | Database user password | |
| PHPBB_DATABASE_PORT_NUMBER | Database server port | 3306 |
| PHPBB_DATABASE_USER | Database user name | phpbb |
| PHPBB_DISABLE_SESSION_VALIDATION | Disable session validation | false |
| PHPBB_EMAIL | phpBB user e-mail address | admin@example.org |
| PHPBB_EXTENSIONS | phpBB extensions to enable (comma-separated) | phpbb/viglink |
| PHPBB_FORUM_DESCRIPTION | phpBB forum description | A little text to describe your forum |
| PHPBB_FORUM_LANGUAGE | phpBB forum language | en |
| PHPBB_FORUM_NAME | phpBB forum name | My forum |
| PHPBB_FORUM_SERVER_PORT | phpBB forum server port | 80 |
| PHPBB_FORUM_SERVER_PROTOCOL | phpBB forum server protocol | http:// |
| PHPBB_HOST | phpBB forum hostname | localhost |
| PHPBB_PASSWORD | phpBB user password | adminadmin |
| PHPBB_SKIP_BOOTSTRAP | Whether to perform initial bootstrapping for the application | false |
| PHPBB_SMTP_HOST | phpBB SMTP server host | |
| PHPBB_SMTP_PASSWORD | phpBB SMTP server user password | |
| PHPBB_SMTP_PORT_NUMBER | phpBB SMTP server port number | |
| PHPBB_SMTP_PROTOCOL | phpBB SMTP server protocol to use | plain |
| PHPBB_SMTP_USER | phpBB SMTP server user | |
| PHPBB_USERNAME | phpBB user name | admin |

## Volumes

The following container paths can be used to mount a dedicated volume or to customize configuration.

| Path | Description |
| ---- | ----------- |
| /etc/apache2/vhosts.d | Virtual hosts configuration (*.conf files) |
| /etc/php8/apache2/php.ini | PHP configuration |
| /srv/www/apps/phpbb/cache | phpBB cache directory |
| /srv/www/apps/phpbb/files | phpBB user uploaded files |
| /srv/www/apps/phpbb/images/avatars/upload | phpBB user uploaded avatars |
| /srv/www/apps/phpbb/store | phpBB store directory |
| /srv/www/htdocs | Default document root |
| /var/lib/php8 | Session save path |

## Useful links

- [Apache HTTPD documentation](https://httpd.apache.org/docs/2.4/)
- [PHP documentation](https://www.php.net/manual/en/)
- [phpBB documentation](https://www.phpbb.com/support/docs/ug/)

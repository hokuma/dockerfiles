#!/bin/bash

if [ "$1" = '/usr/sbin/httpd' ]; then
  htpasswd -bc "/var/www/html/admin/.htpasswd" $USERNAME $PASSWORD
fi
exec "$@"

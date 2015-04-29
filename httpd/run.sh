#!/bin/bash

if [ "$1" = '/usr/sbin/httpd' ]; then
  htpasswd -bc "/.htpasswd" $USERNAME $PASSWORD
fi
exec "$@"

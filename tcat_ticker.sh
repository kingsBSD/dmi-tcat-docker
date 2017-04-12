#!/bin/bash
while true; do
  /usr/bin/php /var/www/html/dmi-tcat/capture/stream/controller.php || true
  sleep 1m
done
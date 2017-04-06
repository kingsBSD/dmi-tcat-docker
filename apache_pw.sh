#!/bin/bash
htpasswd -b -c /etc/apache2/.htpasswd admin $ADMIN_PW
htpasswd -b /etc/apache2/.htpasswd tcat $TCAT_PW

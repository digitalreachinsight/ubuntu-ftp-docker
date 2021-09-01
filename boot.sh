#!/bin/bash
  
# Start the first process
#env > /etc/.cronenv
#
#service cron start &
#status=$?
#if [ $status -ne 0 ]; then
#  echo "Failed to start cron: $status"
#  exit $status
#fi
#
## Start the second process
#cp /etc/postfix-conf/sasl_passwd /etc/postfix/sasl/
#cp /etc/postfix-conf/main.cf /etc/postfix/
#echo container > /etc/mailname
#postmap /etc/postfix/sasl/sasl_passwd
#
#service postfix start &
#status=$?
#if [ $status -ne 0 ]; then
#	  echo "Failed to start postfix: $status"
#	    exit $status
#fi

# Start the second process

chmod 755 /etc/containerscripts/run.sh
/etc/containerscripts/run.sh

#useradd -p $(openssl passwd -1 "Test123") digitalreach2
/etc/init.d/vsftpd restart &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start vsftp: $status"
  exit $status
fi
bash

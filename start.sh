#!/bin/sh

echo "--> start.sh script running..."

run-parts -v  --report /etc/setup.d

envtpl /etc/circus.ini.tpl  --allow-missing --keep-template

echo "---> Starting circus..."
exec /usr/local/bin/circusd /etc/circus.ini 

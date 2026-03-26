#!/bin/bash
# Synaera deployment script
SERVER="147.182.160.48"
KEY="$HOME/.ssh/synaera"

echo "==> Detecting web server on $SERVER..."
ssh -i "$KEY" root@"$SERVER" "
  # Detect web root
  if [ -d /var/www/html ]; then
    WEBROOT=/var/www/html
  elif [ -d /var/www ]; then
    WEBROOT=/var/www
  elif [ -d /usr/share/nginx/html ]; then
    WEBROOT=/usr/share/nginx/html
  else
    WEBROOT=/var/www/html
    mkdir -p \$WEBROOT
  fi
  echo \"WEBROOT=\$WEBROOT\"

  # Detect server type
  if command -v nginx &>/dev/null && systemctl is-active nginx &>/dev/null; then
    echo 'SERVER_TYPE=nginx'
  elif command -v apache2 &>/dev/null && systemctl is-active apache2 &>/dev/null; then
    echo 'SERVER_TYPE=apache'
  else
    echo 'SERVER_TYPE=unknown'
  fi
"

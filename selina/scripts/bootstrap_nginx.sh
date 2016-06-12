#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Bootstrap Nginx ---"

PKG_NGINX="nginx"
IS_PKG_NGINX="$(dpkg --get-selections | grep $PKG_NGINX)"

if [[ "$IS_PKG_NGINX" == "" ]]; then
  rm -f nginx_signing*
  wget http://nginx.org/keys/nginx_signing.key
  apt-key add nginx_signing.key

  cp conf/nginx.list /etc/apt/sources.list.d/
  apt-get update
  apt-get install nginx -y

  service nginx stop
  service nginx start

  log "$PKG_NGINX: installed"

  rm -f nginx_signing*
else
  log "$PKG_NGINX: already installed!"
fi

log "--- End: Bootstrap Nginx ---"
#!/usr/bin/env bash

source "_lib.sh"

log "--- Start: Bootstrap as an Hypervisor ---"

# Use VirtualBox 5.0
PKG_VIRTUALBOX="virtualbox"
IS_PKG_VIRTUALBOX=$(dpkg --get-selections | grep "$PKG_VIRTUALBOX")

if [[ "$IS_PKG_VIRTUALBOX" == "" ]]; then
  cp conf/virtualbox.list /etc/apt/sources.list.d/

  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

  apt-get update
  apt-get install virtualbox-5.0 -y
  apt-get install dkms -y

  log "$PKG_VIRTUALBOX: installed"
else
  log "$PKG_VIRTUALBOX: already installed!"
fi

# Use Vagrant 1.8
PKG_VAGRANT="vagrant"
IS_PKG_VAGRANT=$(dpkg --get-selections | grep "$PKG_VAGRANT")

if [[ "$IS_PKG_VAGRANT" == "" ]]; then
  if [[ ! -f vagrant_1.8.1_x86_64.deb ]]; then
    log "$PKG_VAGRANT: source not found!"
    log "$PKG_VAGRANT: download source!"
    wget https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb
  else
    log "$PKG_VAGRANT: source found."
  fi

  log "$PKG_VAGRANT: installing..."
  dpkg -i vagrant_1.8.1_x86_64.deb

  # fix force install with -f
  apt-get install -f -y

  rm -f vagrant_1*
else
  log "$PKG_VAGRANT: already installed!"
fi

# clean a bit
apt-get autoremove -y

log "--- End: Bootstrap as an Hypervisor ---"
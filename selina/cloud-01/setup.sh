#!/usr/bin/env bash

# Have to be Root
IS_ROOT=$(whoami | grep "root")
if [[ "$IS_ROOT" == "" ]]; then
  echo "* [selina-cloud] not authorized!"
  exit 126
fi

USER_TO_ADD=${1:-chimera}
USER_PASSWD=${2:-eLBkXr4IDea5E}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$CURRENT_DIR/../scripts/"

# Useful func
source "_lib.sh"

# Start serious things here!
log "Update"
apt-get update

# Install default
source bootstrap.sh

# Install Hypervisor
source bootstrap_hypervisor.sh

# Setup default user
log "--- Start: add user $USER_TO_ADD"
if id "$USER_TO_ADD" >/dev/null 2>&1; then
  log "$USER_TO_ADD already exist!"
else
  log "$USER_TO_ADD does not exist"
  log "$USER_TO_ADD is gonna be created.."

  source _user.sh $USER_TO_ADD $USER_PASSWD
fi
log "--- End: add user $USER_TO_ADD"

# Setup default load balancer with Nginx
source bootstrap_nginx.sh

cd "$CURRENT_DIR/"

cp "conf/nginx.conf" /etc/nginx/

service nginx restart

# --- Setup for each VM ---
# TO COMPLETE HERE


log "Setup complete!"

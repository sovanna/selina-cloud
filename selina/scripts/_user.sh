#!/usr/bin/env bash

source "_lib.sh"

USER_TO_ADD=${1:-chimera}
USER_PASSWD=${2:-eLBkXr4IDea5E}

log "--- Start: Setup User $USER_TO_ADD"

useradd "$USER_TO_ADD" --password "$USER_PASSWD" --create-home --groups sudo --shell /bin/bash
echo "$USER_TO_ADD ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$USER_TO_ADD"

log "$USER_TO_ADD added successfully with sudo privilege without password"
log "$USER_TO_ADD should disable root login!"
log "edit /etc/ssh/sshd_config and set PermitRootLogin no and disabled clear password"
log "$USER_TO_ADD should logged into the server before disable root login to avoid locking yourself as a fucking noob!"

log "--- End: Setup User $USER_TO_ADD"
#!/bin/bash
set -euo pipefail

SECRETS_FILE=/run/secrets/authorized_keys

# This won't be executed if keys already exist (i.e. from a volume)
ssh-keygen -A

if [[ -n "${AUTHORIZED_KEYS:-}" ]]; then
  # Copy authorized keys from ENV variable
  echo "$AUTHORIZED_KEYS" | base64 -d >>"$AUTHORIZED_KEYS_FILE"
elif [[ -f "$SECRETS_FILE" ]]; then
  cp "$SECRETS_FILE" "$AUTHORIZED_KEYS_FILE"
else
  >&2 echo "Error! Missing AUTHORIZED_KEYS variable or file in /run/secrets/authorized_keys."
  exit 1
fi

# Chown data folder (if mounted as a volume for the first time)
chown data:data /home/data

# Run sshd on container start
exec /usr/sbin/sshd -D -e

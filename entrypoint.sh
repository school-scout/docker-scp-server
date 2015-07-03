#!/bin/bash

# This won't be executed if keys already exist (i.e. from a volume)
ssh-keygen -A

# Copy authorized keys from ENV variable
echo $AUTHORIZED_KEYS | sed "s/\\$/\n/g" | sed "s/^ //g" >>$AUTHORIZED_KEYS_FILE

# Chown data folder (if mounted as a volume for the first time)
chown data:data /home/data

# Run sshd on container start
exec /usr/sbin/sshd -D -e

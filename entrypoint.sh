#!/usr/bin/env bash

MY_USERNAME="${MY_USERNAME:=ubuntu}"
MY_PASSWORD="${MY_PASSWORD:=ubuntu}"

# Create the user account
groupadd --gid 1020 $MY_USERNAME
useradd --shell /bin/bash --uid 1020 --gid 1020 --password $(openssl passwd $MY_PASSWORD) --create-home --home-dir /home/$MY_USERNAME $MY_USERNAME
usermod -aG sudo $MY_USERNAME

# Start xrdp sesman service
/usr/sbin/xrdp-sesman

# Run xrdp in foreground if no commands specified
if [ -z "$1" ]; then
    /usr/sbin/xrdp --nodaemon
else
    /usr/sbin/xrdp
    exec "$@"
fi

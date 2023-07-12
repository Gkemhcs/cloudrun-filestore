#!/usr/bin/env bash
set -eo pipefail

# Create mount directory for service.
mkdir -p $MNT_DIR

echo "Mounting Cloud Filestore."
mount -o nolock $NFS_IP:/vol1 $MNT_DIR
echo "Mounting completed."

node server.js

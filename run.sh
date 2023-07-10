#!/usr/bin/env bash
set -eo pipefail

# Create mount directory for service.
mkdir -p $MNT_DIR

echo "Mounting Cloud Filestore."
mount -o nolock 10.43.1.2:/gkemhcs $MNT_DIR
echo "Mounting completed."

node server.js

#!/bin/bash

set -ouex pipefail

echo "[syncthing] Installing..."
dnf5 install -y syncthing

echo "[syncthing] Done."
echo "[syncthing] NOTE: enable the user service after first boot with:"
echo "[syncthing]   systemctl --user enable --now syncthing"

#!/bin/bash

set -ouex pipefail

AWCC_VERSION="1.18.1"
AWCC_URL="https://github.com/tr1xem/AWCC/releases/download/v${AWCC_VERSION}/AWCC-v${AWCC_VERSION}.tar.gz"

echo "[awcc] Installing runtime dependencies..."
dnf5 install -y libX11 libglvnd

echo "[awcc] Downloading AWCC v${AWCC_VERSION}..."
mkdir -p /tmp/awcc-extract
curl -fsSL "${AWCC_URL}" -o /tmp/awcc.tar.gz
tar -xzf /tmp/awcc.tar.gz -C /tmp/awcc-extract

echo "[awcc] Installing files..."
install -Dm755 /tmp/awcc-extract/awcc                  /usr/bin/awcc
install -Dm644 /tmp/awcc-extract/database.json         /etc/awcc/database.json
install -Dm644 /tmp/awcc-extract/app/awcc.desktop      /usr/share/applications/awcc.desktop
install -Dm644 /tmp/awcc-extract/app/awcc.png          /usr/share/icons/awcc.png
install -Dm644 /tmp/awcc-extract/app/70-awcc.rules     /etc/udev/rules.d/70-awcc.rules
install -Dm644 /tmp/awcc-extract/app/awccd.service     /etc/systemd/system/awccd.service

echo "[awcc] Enabling awccd service..."
systemctl enable awccd.service

echo "[awcc] Configuring acpi_call auto-load on startup..."
echo "acpi_call" > /etc/modules-load.d/acpi_call.conf

echo "[awcc] Cleaning up..."
rm -rf /tmp/awcc.tar.gz /tmp/awcc-extract

echo "[awcc] Done."

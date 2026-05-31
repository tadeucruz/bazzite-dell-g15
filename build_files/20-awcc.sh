#!/bin/bash

set -ouex pipefail

AWCC_VERSION="1.18.1"
AWCC_URL="https://github.com/tr1xem/AWCC/releases/download/v${AWCC_VERSION}/AWCC-v${AWCC_VERSION}.tar.gz"

echo "[awcc] Installing runtime dependencies..."
dnf5 install -y libX11 libglvnd

echo "[awcc] Downloading AWCC v${AWCC_VERSION}..."
curl -fsSL "${AWCC_URL}" -o /tmp/awcc.tar.gz
tar -xzf /tmp/awcc.tar.gz -C /tmp

echo "[awcc] Installing files..."
install -Dm755 /tmp/AWCC-v${AWCC_VERSION}/awcc                  /usr/bin/awcc
install -Dm644 /tmp/AWCC-v${AWCC_VERSION}/database.json         /etc/awcc/database.json
install -Dm644 /tmp/AWCC-v${AWCC_VERSION}/app/awcc.desktop      /usr/share/applications/awcc.desktop
install -Dm644 /tmp/AWCC-v${AWCC_VERSION}/app/awcc.png          /usr/share/icons/awcc.png
install -Dm644 /tmp/AWCC-v${AWCC_VERSION}/app/70-awcc.rules     /etc/udev/rules.d/70-awcc.rules
install -Dm644 /tmp/AWCC-v${AWCC_VERSION}/app/awccd.service     /etc/systemd/system/awccd.service

echo "[awcc] Enabling awccd service..."
systemctl enable awccd.service

echo "[awcc] Configuring acpi_call auto-load on startup..."
echo "acpi_call" > /etc/modules-load.d/acpi_call.conf

echo "[awcc] Cleaning up..."
rm -rf /tmp/awcc.tar.gz "/tmp/AWCC-v${AWCC_VERSION}"

echo "[awcc] Done."

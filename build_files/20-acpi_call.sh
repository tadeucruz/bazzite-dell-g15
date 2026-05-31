#!/bin/bash

set -ouex pipefail

# Get the exact Bazzite kernel version in the image
KERNEL_VERSION=$(rpm -q --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel | sort -V | tail -1)
echo "[acpi_call] Target kernel: ${KERNEL_VERSION}"

echo "[acpi_call] Installing build dependencies..."
dnf5 install -y gcc make git \
    "kernel-devel-${KERNEL_VERSION}" \
    elfutils-libelf-devel

echo "[acpi_call] Cloning upstream source..."
git clone --depth 1 https://github.com/mkottman/acpi_call.git /tmp/acpi_call

echo "[acpi_call] Compiling module..."
make -C /tmp/acpi_call KDIR="/lib/modules/${KERNEL_VERSION}/build"

echo "[acpi_call] Installing module to /usr/lib/modules/${KERNEL_VERSION}/extra/"
install -Dm644 /tmp/acpi_call/acpi_call.ko \
    "/usr/lib/modules/${KERNEL_VERSION}/extra/acpi_call.ko"

echo "[acpi_call] Running depmod..."
depmod -a "${KERNEL_VERSION}"

echo "[acpi_call] Cleaning up build tools and source..."
rm -rf /tmp/acpi_call
dnf5 remove -y gcc make git elfutils-libelf-devel "kernel-devel-${KERNEL_VERSION}"
dnf5 autoremove -y

echo "[acpi_call] Done."

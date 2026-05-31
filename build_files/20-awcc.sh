#!/bin/bash

set -ouex pipefail

echo "[awcc] Installing runtime dependencies..."
dnf5 install -y \
    libX11 \
    libglvnd \
    libxkbcommon \
    glfw \
    systemd-libs \
    wayland \
    libXrandr \
    libXinerama \
    libXcursor \
    libXi \
    polkit

echo "[awcc] Installing build dependencies..."
dnf5 install -y \
    git cmake ninja-build meson \
    gcc-c++ pkgconf \
    libX11-devel \
    libglvnd-devel \
    libxkbcommon-devel \
    glfw-devel \
    systemd-devel \
    wayland-devel \
    libXrandr-devel \
    libXinerama-devel \
    libXcursor-devel \
    libXi-devel

echo "[awcc] Cloning AWCC source..."
git clone --depth 1 https://github.com/tr1xem/AWCC /tmp/awcc

echo "[awcc] Building..."
cmake -S /tmp/awcc -B /tmp/awcc/build -G Ninja
ninja -C /tmp/awcc/build

echo "[awcc] Installing..."
ninja -C /tmp/awcc/build install

echo "[awcc] Enabling awccd service..."
systemctl enable awccd.service

echo "[awcc] Configuring acpi_call auto-load on startup..."
echo "acpi_call" > /etc/modules-load.d/acpi_call.conf

echo "[awcc] Cleaning up build dependencies..."
rm -rf /tmp/awcc
dnf5 remove -y \
    git cmake ninja-build meson \
    gcc-c++ pkgconf \
    libX11-devel \
    libglvnd-devel \
    libxkbcommon-devel \
    glfw-devel \
    systemd-devel \
    wayland-devel \
    libXrandr-devel \
    libXinerama-devel \
    libXcursor-devel \
    libXi-devel
dnf5 autoremove -y

echo "[awcc] Done."

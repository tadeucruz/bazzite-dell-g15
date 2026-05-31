#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

### acpi_call

# Get the kernel version installed in the image so DKMS can compile against it
KERNEL_VERSION=$(rpm -q --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}\n' kernel | head -1)

# Install kernel headers so DKMS can compile the module during image build
dnf5 install -y "kernel-devel-${KERNEL_VERSION}"

# Install acpi_call via COPR rhea/acpi_call
dnf5 -y copr enable rhea/acpi_call
dnf5 -y install acpi_call-dkms
dnf5 -y copr disable rhea/acpi_call

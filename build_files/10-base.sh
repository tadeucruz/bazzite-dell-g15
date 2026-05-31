#!/bin/bash

set -ouex pipefail

dnf5 install -y tmux

systemctl enable podman.socket

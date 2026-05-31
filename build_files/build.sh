#!/bin/bash
#
# Main build entrypoint for the custom Bazzite image.
#
# This script is called from the Containerfile and runs all numbered scripts
# in build_files/ in order (e.g. 10-base.sh, 20-acpi_call.sh).
#
# To add a new customization, create a new numbered script:
#   build_files/30-my-feature.sh
#
# Scripts are executed with set -ouex pipefail — any failure stops the build.

set -ouex pipefail

for script in /ctx/[0-9]*.sh; do
    echo "[build] Running ${script}..."
    bash "${script}"
done

echo "[build] All scripts completed successfully."

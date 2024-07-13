#!/usr/bin/bash

# ======================================================================================================================
# Install grub-customizer package
#
# Author: kyrex23
# Date:   13/07/2024
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt update && sudo apt install grub-customizer

# Install bigsur theme for grub2: https://github.com/Teraskull/bigsur-grub2-theme
TARGET_DIR="$HOME/Code/repositories/external-tools"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

git clone https://github.com/Teraskull/bigsur-grub2-theme
./bigsur-grub2-theme/install.sh

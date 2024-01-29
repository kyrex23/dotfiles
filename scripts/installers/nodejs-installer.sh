#!/usr/bin/bash

# ======================================================================================================================
# Install the latest current version of NodeJS via package manager
#
# Author: kyrex23
# Date:   29/01/2024
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

# The previous installation of NodeJS must be removed before installing this (if any)
if command -v nodejs > /dev/null 2>&1; then
	echo "Removing the current installed version of nodejs..."
	sudo apt purge nodejs --yes
	echo "Removing all the unused dependencies..."
	sudo apt autoremove --yes
	echo "Done!"
fi

# Create files:
# - /usr/share/keyrings/nodesource.gpg
# - /etc/apt/sources.list.d/nodesource.list
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt update &&\
sudo apt install nodejs --yes

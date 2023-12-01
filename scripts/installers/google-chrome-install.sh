#!/usr/bin/bash

# ======================================================================================================================
# Install Google-Chrome (latest stable) from the official repository
#
# Author: kyrex23
# Date:   01/11/2022
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

URL_KEY="https://dl.google.com/linux/linux_signing_key.pub"
URL_SRC="https://dl.google.com/linux/chrome/deb"

FILE_KEY="/usr/share/keyrings/google-chrome.gpg"
FILE_SRC="/etc/apt/sources.list.d/google-chrome.list"

SYSTEM_ARCH="$(dpkg --print-architecture)"

# ----------------------------------------------------------------------------------------------------------------------

# Download the gpg key and store in a safe place
wget -qO - $URL_KEY | gpg --dearmor | sudo tee $FILE_KEY > /dev/null

# Add the official repository signed by the downloaded key (safe way)
echo "deb [arch=$SYSTEM_ARCH signed-by=$FILE_KEY] $URL_SRC stable main" | sudo tee $FILE_SRC > /dev/null

# Update packages and install/update google-chrome stable
sudo apt update && sudo apt install google-chrome-stable -y

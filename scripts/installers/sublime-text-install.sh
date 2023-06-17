#!/usr/bin/bash

# ======================================================================================================================
# Install Sublime-Text (latest stable) from the official repository
#
# Author: Kyrex
# Date:   01/11/2022
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

URL_KEY="https://download.sublimetext.com/sublimehq-pub.gpg"
URL_SRC="https://download.sublimetext.com"

FILE_KEY="/usr/share/keyrings/sublime-text.gpg"
FILE_SRC="/etc/apt/sources.list.d/sublime-text.list"

SYSTEM_ARCH="$(dpkg --print-architecture)"

# ----------------------------------------------------------------------------------------------------------------------

# Download the gpg key and store in a safe place
wget -qO - $URL_KEY | gpg --dearmor | sudo tee $FILE_KEY > /dev/null

# Add the official repository signed by the downloaded key (safe way)
echo "deb [arch=$SYSTEM_ARCH signed-by=$FILE_KEY] $URL_SRC apt/stable/" | sudo tee $FILE_SRC > /dev/null

# Update packages and install/update sublime-text stable
sudo apt update && sudo apt install sublime-text -y

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

PACKAGE="google-chrome-stable"

# ----------------------------------------------------------------------------------------------------------------------

# Download the gpg key and store in a safe place
if [ -e "$FILE_KEY" ]; then
	echo "A gpg key was found at: $FILE_KEY"
	echo "Renaming to: $FILE_KEY.old..."
	sudo mv "$FILE_KEY" "$FILE_KEY".old
	echo "Done!"
	echo
fi

echo "Downloading a new gpg key and storing it at: $FILE_KEY..."
wget -qO - $URL_KEY | gpg --dearmor | sudo tee $FILE_KEY > /dev/null
echo "Done!"
echo

# Add the official repository signed by the downloaded key (safe way)
echo "Adding the repository at: $FILE_SRC..."
echo "deb [arch=$SYSTEM_ARCH signed-by=$FILE_KEY] $URL_SRC stable main" | sudo tee $FILE_SRC > /dev/null
echo "Done!"
echo

# Update packages and install/update google-chrome stable
echo "Installing the latest stable version..."
sudo apt update && sudo apt install "$PACKAGE" -y
echo "Done!"

#!/usr/bin/bash

# ======================================================================================================================
# Install Spotify (latest stable) from the official repository
#
# Author: kyrex23
# Date:   01/11/2022
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

URL_KEY="https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg"
URL_SRC="http://repository.spotify.com"

FILE_KEY="/usr/share/keyrings/spotify.gpg"
FILE_SRC="/etc/apt/sources.list.d/spotify.list"

SYSTEM_ARCH="$(dpkg --print-architecture)"

# ----------------------------------------------------------------------------------------------------------------------

# Download the gpg key and store in a safe place
wget -qO - $URL_KEY | gpg --dearmor | sudo tee $FILE_KEY > /dev/null

# Add the official repository signed by the downloaded key (safe way)
echo "deb [arch=$SYSTEM_ARCH signed-by=$FILE_KEY] $URL_SRC stable non-free" | sudo tee $FILE_SRC > /dev/null

# Update packages and install/update spotify stable
sudo apt update && sudo apt install spotify-client -y

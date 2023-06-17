#!/usr/bin/bash

# ======================================================================================================================
# Install VSCode (latest stable) from the official repository
#
# Author: Kyrex
# Date:   01/11/2022
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

URL_KEY="https://packages.microsoft.com/keys/microsoft.asc"
URL_SRC="https://packages.microsoft.com/repos/code"

FILE_KEY="/usr/share/keyrings/vscode.gpg"
FILE_SRC="/etc/apt/sources.list.d/vscode.list"

SYSTEM_ARCH="$(dpkg --print-architecture)"

# ----------------------------------------------------------------------------------------------------------------------

# Download the gpg key and store in a safe place
wget -qO - $URL_KEY | gpg --dearmor | sudo tee $FILE_KEY > /dev/null

# Add the official repository signed by the downloaded key (safe way)
echo "deb [arch=$SYSTEM_ARCH signed-by=$FILE_KEY] $URL_SRC stable main" | sudo tee $FILE_SRC > /dev/null

# Update packages and install/update vscode stable
sudo apt update && sudo apt install code -y

# ----------------------------------------------------------------------------------------------------------------------

# Add editorconfig plugin
code --install-extension editorconfig.editorconfig

# Add insert-unicode plugin
code --install-extension brunnerh.insert-unicode

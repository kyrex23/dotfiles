#!/usr/bin/bash

# ======================================================================================================================
# Install Docker (latest stable) from the official repository
#
# Related links:
# - https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
# - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
# - https://askubuntu.com/questions/1296017/what-does-docker-ce-cli-containerd-io-installation-packages-install
#
# Author: kyrex23
# Date:   01/11/2022
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

URL_KEY="https://download.docker.com/linux/ubuntu/gpg"
URL_SRC="https://download.docker.com/linux/ubuntu"

FILE_KEY="/usr/share/keyrings/docker.gpg"
FILE_SRC="/etc/apt/sources.list.d/docker.list"

SYSTEM_ARCH="$(dpkg --print-architecture)"

# ----------------------------------------------------------------------------------------------------------------------

# Download the gpg key and store in a safe place
wget -qO - $URL_KEY | gpg --dearmor | sudo tee $FILE_KEY > /dev/null

# Add the official repository signed by the downloaded key (safe way)
echo "deb [arch=$SYSTEM_ARCH signed-by=$FILE_KEY] $URL_SRC $(lsb_release -cs) stable" | sudo tee $FILE_SRC > /dev/null

# Update packages and install/update docker stable
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# ----------------------------------------------------------------------------------------------------------------------

# Add the current user to the 'docker' group to be able to use it without sudo
# Needs a restart to apply this change or login again with `su - $USER`
sudo usermod -aG docker $USER

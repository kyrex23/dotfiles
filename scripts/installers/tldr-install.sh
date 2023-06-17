#!/usr/bin/bash

# ======================================================================================================================
# Install TLDR using the NodeJS client
#
# Related links:
# - https://itsfoss.com/tldr-linux-man-pages-simplified/
# - https://github.com/tldr-pages/tldr
# - https://npmmirror.com/package/tldr
# - https://www.npmjs.com/package/tldr
#
# Author: Kyrex
# Date:   01/11/2022
# ======================================================================================================================

# Update packages and install/update required packages: {nodejs, npm}
sudo apt update && sudo apt install nodejs npm -y

# Install / Update tldr using npm
sudo npm install --global tldr

# Update the local cache of tldr
tldr --update

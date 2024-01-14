#!/usr/bin/bash

# ======================================================================================================================
# Install `cheat.sh` client: https://github.com/chubin/cheat.sh
#
# Author: kyrex23
# Date:   30/12/2023
# ======================================================================================================================

# `rlwrap` is a required dependency to run in shell mode
sudo apt install rlwrap


# Current user installation

LOCAL_BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

LOCAL_OUT_BIN="$LOCAL_BIN_DIR/cht.sh"

curl --silent https://cht.sh/:cht.sh > "$LOCAL_OUT_BIN"
chmod +x "$LOCAL_OUT_BIN"


# Global installation (all users)

#GLOBAL_OUT_BIN="/usr/local/bin/cht.sh"
#curl -s https://cht.sh/:cht.sh | sudo tee "$GLOBAL_OUT_BIN" && sudo chmod +x "$GLOBAL_OUT_BIN"

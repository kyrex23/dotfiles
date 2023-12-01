# Add ~/.local/bin to the PATH with higher priority
export PATH="$HOME/.local/bin:$PATH"

# Environment variables for dotfiles management
export DOTFILES="$HOME/Code/dotfiles"

# Environment variables required for Go
export GOPATH="$HOME/go"         # This env is automatically set
export GOBIN="$GOPATH/bin"
export GOROOT="/usr/local/go"    # This env is automatically set
export PATH="$PATH:$GOBIN:$GOROOT/bin"

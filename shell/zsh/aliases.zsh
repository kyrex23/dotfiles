# Allows you to use 'sudo' before other aliases
alias sudo='sudo '

alias la='ls -l --almost-all --human-readable --group-directories-first'
alias lah='ls -l --almost-all --human-readable --dereference-command-line --group-directories-first'
alias lar='ls -l --almost-all --human-readable --dereference-command-line --group-directories-first --recursive'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -out -selection clipboard'

# Clean untagged images (none:none)
alias docker-clean-images='docker rmi $(docker images --filter dangling=true --format="{{.ID}}")'

alias clean-metadata='exiftool -all='

alias clean-suggestions='rm $HISTFILE'

# Allows you to use 'sudo' before other aliases
alias sudo='sudo '

# ======================================== Basic aliases for util cli commands =========================================
alias la='ls -l --almost-all --human-readable --group-directories-first'
alias lah='ls -l --almost-all --human-readable --dereference-command-line --group-directories-first'
alias lar='ls -l --almost-all --human-readable --dereference-command-line --group-directories-first --recursive'

alias tree='tree -al --dirsfirst --sort name -I .git'
alias treefull='tree -al -uh -F --dirsfirst --sort name -I .git'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -out -selection clipboard'

alias deeplen='deepl --fr es --to en --stdin'
alias deeples='deepl --fr en --to es --stdin'
# ======================================================================================================================
alias dotfiles='code $DOTFILES'

# Clean untagged images (none:none)
alias docker-clean-images='docker rmi $(docker images --filter dangling=true --format="{{.ID}}")'

alias clean-metadata='exiftool -all='

alias clean-suggestions='rm $HISTFILE'

bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
export PATH="/opt/homebrew/bin:$PATH"
export EDITOR=nvim
export PS1="%2~ %(1j.%F{red}%B%j%f%b.)%m%# "
alias gs="git status"
alias gc="git commit"
[ -f ~/.env ] && . ~/.env

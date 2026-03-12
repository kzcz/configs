[[ $- != *i* ]] && return
shopt -s histappend
shopt -s histverify
source /etc/environment
export HISTCONTROL=ignoredups:erasedups
alias ls='ls --color=auto'
alias ll='ls --color=auto -lAh'
alias grep='grep --color=auto'
alias ..='cd ..'
alias nv=nvim
__prompt__() {
    local CD=$?
    local N='\[\e[0m\]'; local R='\[\e[0;31m\]'; local G='\[\e[0;32m\]'; local C='\[\e[1;36m\]'
    local ES=''; [ $CD -ne 0 ] && ES="($CD) ";
    local TM=$(date +$'\\[\e[1;95m\\]%H\\[\e[0m\\]:\\[\e[1;96m\\]%M\\[\e[0m\\]:\\[\e[1;91m\\]%S\\[\e[0m\\]')
    PS1="$N[ ${TM} ${ES}${R}\u${N}@${G}\h ${C}\w${N} ] \$ "
}
PROMPT_COMMAND=__prompt__
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi
__pae() {
    local ed="$1 $EDITOR $2";
    local rl="source $2"; $ed && $rl;
}
wp() {
    [ -z "$@" ] && echo "Usage: wp command" && return 1
    local w=$(which "$@" 2>/dev/null)
    [ -z "$w" ] && echo "Which failed." && return 2
    pacman -Qo "$w"
}
alias rbc="__pae '' $HOME/.bashrc"
alias rgc="__pae sudo /etc/bash.bashrc"
alias rec="__pae sudo /etc/environment"


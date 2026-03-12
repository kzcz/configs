[[ $- != *i* ]] && return
shopt -s histappend
shopt -s histverify
if [ -x "/data/data/com.termux/files/usr/libexec/termux/command-not-found" ]; then
	command_not_found_handle() {
		"/data/data/com.termux/files/usr"/libexec/termux/command-not-found "$1"
	}
fi
source $PREFIX/etc/environment
export HISTCONTROL=ignoredups:erasedups
alias ls='ls --color=auto'
alias ll='ls --color=auto -lAh'
alias grep='grep --color=auto'
alias ..='cd ..'
alias nv=nvim
__prompt__() {
    local CD=$?
    local N='\[\e[0m\]'; local G='\[\e[0;32m\]'; local C='\[\e[1;36m\]'
    local ES=''; [ $CD -ne 0 ] && ES="($CD) ";
    local TM=$(date +$'\\[\e[1;95m\\]%H\\[\e[0m\\]:\\[\e[1;96m\\]%M\\[\e[0m\\]:\\[\e[1;91m\\]%S\\[\e[0m\\]')
    PS1="$N[ ${TM} ${ES}${G}(EDIT ME) ${C}\w${N} ] \$ "
}
PROMPT_COMMAND=__prompt__
if [[ -r $PREFIX/share/bash-completion/bash_completion ]]; then
  . $PREFIX/share/bash-completion/bash_completion
fi
__pae() {
    $EDITOR $1 && source $1;
}
wp() {
    [ -z "$@" ] && echo "Usage: wp command" && return 1
    local w=$(which "$@" 2>/dev/null)
    [ -z "$w" ] && echo "Which failed." && return 2
    dpkg -S "$w"
}
alias rbc="__pae $HOME/.bashrc"
alias rgc="__pae $PREFIX/etc/bash.bashrc"
alias rec="__pae $PREFIX/etc/environment"


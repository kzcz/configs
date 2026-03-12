[[ $- != *i* ]] && return
source $PREFIX/etc/environment
setopt sharehistory
setopt histignorealldups histsavenodups histexpiredupsfirst histfindnodups
setopt extendedhistory
setopt histreduceblanks
setopt histignorespace
setopt interactivecomments
setopt autocd beep nomatch notify
if [ -x "/data/data/com.termux/files/usr/libexec/termux/command-not-found" ]; then
	command_not_found_handler() {
		"/data/data/com.termux/files/usr"/libexec/termux/command-not-found "$1"
	}
fi
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000

autoload -Uz compinit
compinit

alias ls='ls --color=auto'
alias ll='ls --color=auto -lAh'
alias grep='grep --color=auto'
alias nv=nvim
__pae() {
    $EDITOR "$1" && source "$1"
}
_wp() {
    local keys=(${(k)commands})
    compadd -- "${keys[@]}"
}
wp() {
    ! (( # )) && echo "Usage: wp command" && return 1
    (( $+commands[$1] )) && dpkg -S "$commands[$1]" || { echo "No such command"; return 2; }
}


compdef _wp wp

alias rzc="__pae $HOME/.zshrc"
alias rgc="__pae $PREFIX/etc/zshrc"
alias rec="__pae $PREFIX/etc/environment"

PROMPT='[ %B%F{13}%D{%H}%f%b:%B%F{14}%D{%M}%f%b:%B%F{9}%D{%S}%f%b %(?..(%?%) )%F{green}(EDIT ME) %f%F{14}%~%f ] %# '

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:approximate:*' original true
zstyle ':completion:*:correct:*'     original true

bindkey -e 
if (( $+terminfo[smkx] && $+terminfo[rmkx] )); then 
    function zle-line-init () { echoti smkx }
    function zle-line-finish () { echoti rmkx }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kich1]}" overwrite-mode
bindkey '^I' complete-word

source $PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[comment]="fg=magenta,bold,underline"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=red,bold"
ZSH_HIGHLIGHT_STYLES[cursor]="underline,bold,standout"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)

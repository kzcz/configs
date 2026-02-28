[[ $- != *i* ]] && return
source /etc/environment
setopt sharehistory
setopt histignorealldups histsavenodups histexpiredupsfirst histfindnodups
setopt extendedhistory
setopt histreduceblanks
setopt histignorespace
setopt interactivecomments
setopt autocd beep nomatch notify
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
    local cmd=($1 $EDITOR $2)
    "$cmd[@]" && source "$2"
}
_wp() {
    local keys=(${(k)commands})
    compadd -- "${keys[@]}"
}
wp() {
    ! (( # )) && echo "Usage: wp command" && return 1
    (( $+commands[$1] )) && pacman -Qo "$commands[$1]" || { echo "No such command"; return 2; }
}


compdef _wp wp

alias rzc="__pae '' $HOME/.zshrc"
alias rgc="__pae sudo /etc/zsh/zshrc"
alias rec="__pae sudo /etc/environment"

PROMPT='[ %B%F{13}%D{%H}%f%b:%B%F{14}%D{%M}%f%b:%B%F{9}%D{%S}%f%b %(?..(%?%) )%F{red}%n%f@%F{green}%m%f %F{14}%~%f ] %# '

zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:approximate:*' original true
zstyle ':completion:*:correct:*'     original true

bindkey -e 

function zle-line-init () { echoti smkx }
function zle-line-finish () { echoti rmkx }
zle -N zle-line-init
zle -N zle-line-finish

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kich1]}" overwrite-mode
bindkey '^I' complete-word

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[comment]="fg=magenta,bold,underline"
ZSH_HIGHLIGHT_STYLES[reserved-word]="fg=red,bold"
ZSH_HIGHLIGHT_STYLES[cursor]="underline,bold,standout"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)

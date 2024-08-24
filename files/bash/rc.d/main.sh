# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

source "/usr/share/blesh/ble.sh" --noattach

HISTFILESIZE=100000
HISTSIZE=10000

export GPG_TTY="$(tty)"

EDITOR=nvim
VISUAL=nvim

export EDITOR VISUAL

set -o vi

shopt -s histappend
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

alias ls=lsd

eval "$(dircolors ~/.config/dircolors)"

eval "$(starship init bash --print-full-init)"
eval "$(zoxide init bash)"

eval "$(~/.local/bin/mise activate bash)"

[[ ${BLE_VERSION-} ]] && ble-attach

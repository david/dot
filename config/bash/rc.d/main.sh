# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

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

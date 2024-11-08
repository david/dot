set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PODMAN_COMPOSE_WARNING_LOGS false

set -l BREW_HOME /home/linuxbrew/.linuxbrew

$BREW_HOME/bin/brew shellenv | source

if [ -d $BREW_HOME/lib/ruby/gems/3.3.0/bin ]
  fish_add_path --prepend --path $BREW_HOME/lib/ruby/gems/3.3.0/bin
end

fish_add_path --prepend --path $HOME/.local/bin

set -U fish_greeting ""

if status is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line

  fish_vi_key_bindings

  alias ls lsd
  alias ll "ls -l"
  alias la "ls -a"
  alias lla "ls -la"

  alias ssh "distrobox-host-exec ssh $argv"

  atuin init fish | source
  direnv hook fish | source
  starship init fish | source
  zoxide init fish | source
end

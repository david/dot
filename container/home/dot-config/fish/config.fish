set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PODMAN_COMPOSE_WARNING_LOGS false

umask 077

fish_add_path --prepend --path $HOME/.local/opt/ruby/bin
fish_add_path --prepend --path $HOME/.local/bin

set -U fish_greeting ""

if status is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line

  fish_vi_key_bindings

  alias ls eza
  alias ll "ls -l"
  alias la "ls -a"
  alias lla "ls -la"

  atuin init fish | source
  direnv hook fish | source
  starship init fish | source
  zoxide init fish | source
end

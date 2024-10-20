set -gx EDITOR nvim
set -gx VISUAL nvim

set -l BREW_HOME /home/linuxbrew/.linuxbrew

$BREW_HOME/bin/brew shellenv | source

set -U fish_greeting ""

fish_add_path --prepend --path $BREW_HOME/lib/ruby/gems/3.3.0/bin
fish_add_path --prepend --path $HOME/.local/bin

if status is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line

  fish_vi_key_bindings

  alias ls lsd
  alias ll "ls -l"
  alias la "ls -a"
  alias lla "ls -la"

  atuin init fish | source
  direnv hook fish | source
  starship init fish | source
  zoxide init fish | source
end

set -gx EDITOR nvim
set -gx VISUAL nvim

/home/linuxbrew/.linuxbrew/bin/brew shellenv | source

set -U fish_greeting ""

fish_add_path --prepend --path /home/linuxbrew/.linuxbrew/lib/ruby/gems/3.3.0/bin

if status is-interactive
  set fish_cursor_default block
  set fish_cursor_insert line

  fish_vi_key_bindings

  alias ls=lsd
  alias ll="ls -l"
  alias la="ls -a"
  alias lla="ls -la"

  atuin init fish | source
  direnv hook fish | source
  starship init fish | source
  zoxide init fish | source
end

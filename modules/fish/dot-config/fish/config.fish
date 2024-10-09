set -gx EDITOR nvim
set -gx VISUAL nvim

fish_add_path --prepend --path ~/.local/bin

if status is-interactive
  set -U fish_greeting ""

  set fish_cursor_default block
  set fish_cursor_insert line

  fish_vi_key_bindings

  alias ll="ls -l"
  alias la="ls -a"
  alias lla="ls -la"
end

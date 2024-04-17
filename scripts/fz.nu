#!/usr/bin/env nu

export-env {
  $env.FZF_DEFAULT_OPTS = (
    [
      "--ansi"
      "--cycle"
      "--header=''"
      "--info=inline-right"
      "--layout=reverse"
      "--no-scrollbar"
      "--pointer=' '"
      "--prompt '  '"
      "--color 'fg:#ebdbb2,fg+:#1d2021,bg+:#d79921,gutter:#000000,pointer:#000000'"
    ] | str join " "
  )
}

export def main [] {}

export def "main file find" [] {
  let cmd = if (which find-file | is-not-empty) { "find-file" } else { "fd" }

  run-external $cmd | filter | str trim
}

def "main recent-directory" [--json] {
  let choice = (
    glob --depth 1 $"($env.HOME)/ar/trees/*"
    | append $"($env.HOME)/church"
    | append $"($env.HOME)/sys"
    | sort
    | par-each { |e| $"($e | str replace $"($env.HOME)/" "")\t($e)" }
    | to text
    | filter
    | split column "\t" label name
    | first
  )

  if $json {
    $choice | to json
  } else {
    $choice
  }
}

def "main window-list" [--json] {
  let ws = (wm workspace)

  let choice = (
    wm win ls
    | where workspace.id == $ws.id
    | select title id
    | to csv --separator "\t" --noheaders
    | filter
    | split column "\t" title id
    | first
  )

  if $json {
    $choice | to json
  } else {
    $choice
  }
}

def "main window" [--basedir: path, filter: string] {
  (
    kitty --class menu
          --override window_padding_width=8
          --override forward_stdio=yes
          --directory $basedir
          bash -c $"fz.nu ($filter) --json >&3"
  )
}

def "main text" [--json] {
  let rg = "rg --column --line-number --no-heading --color=always --smart-case"

  echo ""
  | (
      fzf --bind $"change:reload:($rg) {q} || true"
          --bind $"enter:execute(kittyctl.nu new --class nvim nvim {1} '+normal {2}G{3}|')"
          --bind $"focus:transform-header:echo ' {1}'"
          --delimiter=:
          --disabled
          --no-scrollbar
          --with-nth=4
    )
  | split column ":" filename line column match
  | first
}

def filter [] {
  $in
  | fzf --delimiter="\t" --with-nth=1
  | lines
  | last
}

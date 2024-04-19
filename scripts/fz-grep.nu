#!/usr/bin/env nu

use fz.nu
use wm.nu

export def "main ui" [] {
  let socket = $"($env.HOME)/.cache/preview.(date now | format date %s.%f).sock"

  systemd-run --user term --class "preview" nvim --listen $socket

  sleep 0.1sec

  wm open --above {
    term --class "menu" --group "menu" $env.PROCESS_PATH --socket $socket
    nvim --server $socket --remote-send "<cmd>q<cr>"
  }
}

export def "main open" [--socket: path, file: path, row: int, col: int] {
  nvim --server $socket --remote $"($file)"
  nvim --server $socket --remote-send $"($row)G($col)|"
}

def main [--socket: path] {
  let rg = "rg --column --line-number --no-heading --color=always --smart-case"

  echo ""
  | (
    fzf --bind $"change:reload:\(($rg) {q} || true\)"
        --bind $"focus:execute-silent\(($env.PROCESS_PATH) open --socket ($socket) '{1}' {2} {3}\)"
        --delimiter :
        --disabled
        --no-scrollbar
  )
}



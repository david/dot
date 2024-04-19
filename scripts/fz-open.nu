#!/usr/bin/env nu

use fz.nu
use wm.nu

export def "main ui" [] {
  wm open --above { term --class menu --group menu $env.PROCESS_PATH }
}

export def main [] {
  let cmd = if (which fz-open-local | is-not-empty) {
    [ fz-open-local ]
  } else {
    [ fd --type f ]
  }

  run-external ($cmd | first) ...($cmd | skip 1) | (
    fzf
      --bind "enter:become(term --detach nvim {})"
      --delimiter="\t"
      --scheme=path
      --tiebreak=length,end,index
      --with-nth=1
  )
}

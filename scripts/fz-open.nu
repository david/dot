#!/usr/bin/env nu

use fz.nu
use wm.nu

export def "main ui" [] {
  wm open --above { term --class menu --group menu $env.PROCESS_PATH }
}

export def main [] {
  fd --type f | ^sort | (
    fzf
      --bind "enter:become(term --detach nvim {})"
      --scheme=path
      --tiebreak=length,end,index
      --with-nth=1
  )
}

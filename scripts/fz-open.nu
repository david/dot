#!/usr/bin/env nu

use fz.nu
use wm.nu

export def "main ui" [] {
  wm open --above {
    let choice = (term pipe $env.PROCESS_PATH | str trim)

    if ($choice | is-not-empty) {
      term --detach nvim $choice
    }
  }
}

export def main [] {
  let cmd = if (which fz-open-local | is-not-empty) { "fz-open-local" } else { "fd" }

  let choice = (
    run-external $cmd
    | fzf --delimiter="\t" --scheme=path --tiebreak=length,end,index --with-nth=1
    | lines
    | last
  )

  if ($choice | is-not-empty) { $choice }
}

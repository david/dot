#!/usr/bin/env nu

use fz.nu

export def "main ui" [] {
  ws term $env.PROCESS_PATH
}

export def main [] {
  let cmd = if (which fz-file-local | is-not-empty) { "fz-file-local" } else { "fd" }

  let choice = (
    run-external $cmd
    | fzf --delimiter="\t" --scheme=path --tiebreak=length,end,index --with-nth=1
    | lines
    | last
    | str trim
  )

  if ($choice | is-not-empty) { ws run nvim $choice }
}

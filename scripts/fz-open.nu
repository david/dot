#!/usr/bin/env nu

use fz.nu
use wm.nu

export def "main ui" [] {
  wm open --above { term --title fz-open --class menu --group menu $env.PROCESS_PATH }
}

export def main [] {
  let workspace = (wm ws)
  let windows = (
    wm win list 
    | where workspace.id == $workspace.id and title != "fz-open"
    | insert label { |e| $"(ansi light_gray)󰣆 (ansi reset) ($e.title)" } 
    | insert type "window"
    | select label id type
    | to csv --separator "\t" --noheaders
  )

  let files = (fd --type f --exec echo $"(ansi light_cyan) (ansi reset) {}\t{}\tfile" | ^sort)

  let raw_choice = (($windows + $files) | fzf --delimiter "\t" --tiebreak=end,length --with-nth=1 --no-sort)

  if ($raw_choice | is-empty) {
    return
  }

  let choice = (
    $raw_choice
    | from csv --noheaders --separator "\t"
    | rename label id type
    | first
  )

  match $choice.type {
    "window" => { wm focus $choice }
    "file" => { term --detach nvim $choice.id }
  }
}

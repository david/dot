#!/usr/bin/env nu

def main [] {
  print --no-newline (ansi cursor_off)

  loop { 
    run-external $env.CURRENT_FILE render
    sleep 1sec
  }
}

def "main render" [] {
  render
}

def render [] {
  let date = (
    date now 
    | format date $"%a, %b %-e (ansi grey)//(ansi reset) %H:%M" 
    | fill --alignment center --width (term size | get columns)
    | str trim --char "\n"
  )

  print --no-newline $"(tput cup 0 0)($date)(ansi erase_line_from_cursor_to_end)"
}

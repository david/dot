#!/usr/bin/env nu

use widget.nu

def main [] {
  loop { 
    date now | format date $"%a, %b %-e (ansi grey)//(ansi reset) %H:%M" | widget center | widget render
    sleep 1sec
  }
}

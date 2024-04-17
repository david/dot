#!/usr/bin/env nu

def main [] {
  sleep 0.1sec

  print --no-newline (ansi cursor_off)

  mut i = 0
  mut out = {
    battery: (battery | battery render)
    cpu: (cpu | cpu render)
    temp: (cpu | temp render)
    wifi: (wifi | wifi render)
  }

  loop { 
    let cols = (term size | get columns)
    let strip = (
      [
        $out.battery  
        $out.temp 
        ($out.cpu | fill --width 7)
        ($out.wifi | fill --width 7)
      ] 
      | str join "       "
      | fill --alignment center --width $cols
    )

    print --no-newline $"(tput cup 0 0)($strip)(ansi erase_line_from_cursor_to_end)"

    if $i mod 2 == 0 {
      $out = ($out | merge { cpu: (cpu | cpu render)})
    }

    if $i mod 5 == 0 {
      $out = (
        $out | merge { 
          battery: (battery | battery render)
          temp: (temp | temp render) 
        }
      )
    }

    if $i mod 10 == 0 {
      $out = ($out | merge { wifi: (wifi | wifi render)})
    }

    $i = $i + 1

    sleep 1sec
  }
}

def battery [] {
  (
    dbus-send 
      --system 
      --print-reply=literal 
      --dest=org.freedesktop.UPower 
      /org/freedesktop/UPower/devices/battery_BAT0 
      org.freedesktop.DBus.Properties.Get string:org.freedesktop.UPower.Device string:Percentage
    | str trim
    | split column --regex "\\s+" 
    | get column3
    | first
    | into int
  )
}

def "battery render" [] {
  let val = $in
  let r = $"(ansi grey)󰁹 (ansi reset) ($val)(ansi grey) (ansi reset)"

  if $val < 25 {
    $"(ansi red)($r)(ansi reset)"  
  } else if $val < 50 {
    $"(ansi yellow)($r)(ansi reset)"  
  } else {
    $r
  }
}

def cpu [] {
  sys | get cpu.cpu_usage | into int | math max
}

def "cpu render" [] {
  let val = $in
  let r = $"(ansi grey) (ansi reset) ($val)(ansi grey) (ansi reset)"

  if $val > 90 {
    $"(ansi purple)($r)(ansi reset)"
  } else if $val > 50 {
    $"(ansi yellow)($r)(ansi reset)"
  } else {
    $r
  }
}

def temp [] {
  sys | get temp | where unit starts-with coretemp | get temp | into int | math max
}

def "temp render" [] {
  let val = $in

  $"(ansi grey)󰔏 (ansi reset) ($val)(ansi grey)󰔄 (ansi reset)"
}

def wifi [] {
  let conn = (
    nmcli -g IN-USE,SIGNAL d wifi
    | lines
    | split column : in-use signal
    | where in-use == "*"
  )

  if ($conn | is-not-empty) {
    $conn | first | get signal | into int
  } 
}

def "wifi render" [] {
  let val = $in

  if ($val | is-empty) {
    "󰤭 "
  } else if $val < 25 {
    $"(ansi red)󰤟  ($val) (ansi reset)"
  } else if $val < 50 {
    $"(ansi yellow)󰤢  ($val) (ansi reset)"
  } else if $val < 75 {
    $"(ansi light_yellow)󰤥  ($val) (ansi reset)"
  } else {
    $"(ansi grey)󰤨 (ansi reset) ($val)(ansi grey) (ansi reset)"
  }
}

#!/usr/bin/env nu

use widget.nu [fade nudge spread warn yell]

def main [] {
  sleep 0.1sec

  print --no-newline (ansi cursor_off)

  let cols = (term size | get columns)

  mut i = 0
  mut out = {
    battery: (battery | battery render)
    cpu: (cpu | cpu render)
    temp: (cpu | temp render)
    wifi: (wifi | wifi render)
  }

  loop {
    let strip = [ $out.battery, $out.temp, $out.cpu, $out.wifi ] | spread

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

    null
  }
}

def battery [] {
  let charge = (
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

  let state = (
    dbus-send
      --system
      --print-reply=literal
      --dest=org.freedesktop.UPower
      /org/freedesktop/UPower/devices/battery_BAT0
      org.freedesktop.DBus.Properties.Get string:org.freedesktop.UPower.Device string:State
    | str trim
    | split column --regex "\\s+"
    | get column3
    | first
    | into int
  )

  {
    charge: $charge
    state: ($state | into int)
  }
}

def "battery render" [] {
  let batt = $in

  let icon = match $batt.state {
    1 => "󱐋 "
    2 => "󰁹 "
    4 => "󰛨 "
    _ => $batt.state
  }

  if $batt.charge < 25 {
    $"($icon) ($batt.charge) " | yell
  } else if $batt.charge < 50 {
    $"($icon) ($batt.charge) " | warn
  } else {
    $"($icon | fade) ($batt.charge)(' ' | fade)"
  }
}

def cpu [] {
  sys | get cpu.cpu_usage | into int | math max
}

def "cpu render" [] {
  let val = $in

  if $val > 90 {
    $"  ($val) " | yell
  } else if $val > 50 {
    $"  ($val) " | warn
  } else {
    $"(' ' | fade) ($val)(' ' | fade)"
  }
}

def temp [] {
  sys | get temp | where unit starts-with coretemp | get temp | into int | math max
}

def "temp render" [] {
  let val = $in

  $"('󰔏 ' | fade) ($val)('󰔄 ' | fade)"
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
    "󱜡 "
  } else if $val < 25 {
    $"󱜠  ($val) " | yell
  } else if $val < 50 {
    $"󱜠  ($val) " | warn
  } else if $val < 75 {
    $"󱜠  ($val) " | nudge
  } else {
    $"('󱜠 ' | fade) ($val)(' ' | fade)"
  }
}

#!/usr/bin/env nu

def main [...args] {
  match $args {
    ["brightness" "down"] => { brightness down }
    ["brightness" "info"] => { brightness info }
    ["brightness" "up"] => { brightness up }
    ["track" "next"] => { track next }
    ["track" "play-pause"] => { track play-pause }
    ["track" "prev"] => { track previous }
    ["vol" "down"] => { volume down }
    ["vol" "info"] => { volume info }
    ["vol" "mute"] => { volume mute }
    ["vol" "up"] => { volume up }
  }
}

def "track play-pause" [] {
  playerctl play-pause
}

def "track next" [] {
  playerctl next
}

def "track previous" [] {
  playerctl previous
}

def "brightness up" [] {
  (brightnessctl set 5%+)
  notify (brightness info)
}

def "brightness down" [] {
  (brightnessctl set 5%-)
  notify (brightness info)
}

def "brightness info" [] {
  brightnessctl info 
  | lines 
  | enumerate 
  | where item =~ "Current brightness" 
  | str trim 
  | get item 
  | parse "Current brightness: {intval} ({percent})" 
  | update percent { |e| $e.percent | str trim --char % }
  | insert type brightness  
  | insert icon display-brightness-symbolic
  | first
}

def notify [info: record] {
  let old_notification_id = (
    if ($"($env.HOME)/.local/state/timbuktu/media_notification_id" | path exists) {
      open $"($env.HOME)/.local/state/timbuktu/media_notification_id" | str trim
    } else {
      0
    }
  )

  let new_notification_id = (
    notify-send " " 
      -i $info.icon
      -p 
      -t 3000
      -r ($old_notification_id | default 0) 
      -h $"int:value:($info.percent)" 
      -h $"string:synchronous:($info.type)"
  )

  mkdir $"($env.HOME)/.local/state/timbuktu"

  $new_notification_id | save --force $"($env.HOME)/.local/state/timbuktu/media_notification_id"
}

def "volume up" [] {
  pamixer --increase 5
  ogg123 /run/current-system/sw/share/sounds/freedesktop/stereo/audio-volume-change.oga
  notify (volume info)
}

def "volume down" [] {
  pamixer --decrease 5
  ogg123 /run/current-system/sw/share/sounds/freedesktop/stereo/audio-volume-change.oga
  notify (volume info)
}

def "volume info" [] {
  { type: volume, icon: audio-speakers-symbolic, percent: (pamixer --get-volume) }
}

def "volume mute" [] {
  pamixer --mute
}

def "microphone mute" [] {
  pamixer --default-source --toggle-mute
}

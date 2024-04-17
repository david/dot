use wm.nu

export def root [] {
  "." | path expand
}

export def id [] {
  (wm ws | get id) / 100 | into int
}

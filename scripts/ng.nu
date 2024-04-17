export def "branch new" [name: string] {
  git checkout -b $name
}

export def update [] {
  git fetch --prune
}

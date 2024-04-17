#!/usr/bin/env nu

export def main [] {}

export def "main dismiss" [] {
  let fst = (
    makoctl list
    | from json
    | get data
    | append [ null ]
    | first
    | first
  )

  if $fst != null {
    makoctl dismiss -n $fst.id.data
  }
}

export def truncate [max_width: int] {
  let str = $in

  if ($str | str length) > $max_width {
    $str | split chars | take ($max_width - 1) | append "…" | str join ""
  } else {
    $str
  }
}


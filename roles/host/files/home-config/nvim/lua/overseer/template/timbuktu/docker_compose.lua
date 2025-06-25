return {
  name = "docker compose",
  builder = function()
    return {
      cmd = { "docker" },
      args = { "compose", "up" },
      components = { "unique", "default" },
    }
  end,
}

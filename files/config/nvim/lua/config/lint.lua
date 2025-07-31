local CONFIG_PATH = os.getenv("XDG_CONFIG_HOME") .. "/markdownlint-cli2.yaml"

return {
  "mfussenegger/nvim-lint",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", CONFIG_PATH, "--" },
      },
    },
  },
}

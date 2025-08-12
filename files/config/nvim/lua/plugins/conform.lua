return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      ["*"] = { "trim_whitespace" },
    },
    format_after_save = {
      async = true,
      lsp_format = "fallback",
      timeout_ms = 500,
    },
    notify_no_formatters = false,
  },
}

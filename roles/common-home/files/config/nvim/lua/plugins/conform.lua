
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>df",
      function()
        require("conform").format({
          async = true,
          lsp_fallback = true,
        })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    format_on_save = function()
      if next(vim.fs.find({ "mix.exs" }, { limit = 1 })) == nil then
        return { timeout_ms = 500, lsp_format = "fallback" }
      else
        return { timeout_ms = 2000, lsp_format = "fallback" }
      end
    end,
    formatters_by_ft = {
      elixir = { "mix" },
      eelixir = { "mix" },
      heex = { "mix" },
      lua = { "stylua" },
      ruby = { "rubocop" },
      ["*"] = { "trim_whitespace" },
    },
    notify_on_error = false,
  },
}

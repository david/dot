-- [nfnl] fnl/plugins/lspconfig.fnl
local function _1_()
  local function _2_(diagnostic)
    local diagnostic_message = {[vim.diagnostic.severity.ERROR] = diagnostic.message, [vim.diagnostic.severity.WARN] = diagnostic.message, [vim.diagnostic.severity.INFO] = diagnostic.message, [vim.diagnostic.severity.HINT] = diagnostic.message}
    return diagnostic_message[diagnostic.severity]
  end
  return vim.diagnostic.config({severity_sort = true, float = {border = "rounded", source = "if_many"}, underline = {severity = vim.diagnostic.severity.ERROR}, signs = {text = {[vim.diagnostic.severity.ERROR] = "\243\176\133\154 ", [vim.diagnostic.severity.WARN] = "\243\176\128\170 ", [vim.diagnostic.severity.INFO] = "\243\176\139\189 ", [vim.diagnostic.severity.HINT] = "\243\176\140\182 "}}, virtual_text = {source = "if_many", spacing = 2, format = _2_}})
end
return setup("neovim/nvim-lspconfig", {config = _1_, dependencies = {kv("mason-org/mason.nvim", {opts = {}}), kv("mason-org/mason-lspconfig.nvim", {opts = {ensure_installed = {"biome", "expert", "lua_ls", "ruby_lsp", "tailwindcss", "ts_ls"}}}), kv("WhoIsSethDaniel/mason-tool-installer.nvim", {opts = {ensure_installed = {"erb-formatter", "stylua"}}}), kv("j-hui/fidget.nvim", {opts = {}}), "saghen/blink.cmp"}})

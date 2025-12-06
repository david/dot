local M = {}

M.setup = function(config)
  for k, v in pairs(config.g) do
    vim.g[k] = v
  end

  for k, v in pairs(config.opt) do
    vim.opt[k] = v
  end

  vim.cmd.colorscheme({ args = { config.colorscheme } })
end

return M

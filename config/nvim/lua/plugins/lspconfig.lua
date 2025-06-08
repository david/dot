
return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("timbuktu-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", function()
          require("snacks").picker.lsp_definitions()
        end, "Go to definition")
        map("gr", function()
          require("snacks").picker.lsp_references()
        end, "Go to references")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>fm", function()
          require("snacks").picker.lsp_symbols()
        end, "Symbols")
        map("<leader>rn", vim.lsp.buf.rename, "Rename")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup("timbuktu-lsp-highlight", { clear = false })

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("timbuktu-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({
                group = "timbuktu-lsp-highlight",
                buffer = event2.buf,
              })
            end,
          })
        end
      end,
    })

    vim.api.nvim_create_autocmd("LspProgress", {
      callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), "info", {
          id = "lsp_progress",
          title = "LSP Progress",
          opts = function(notif)
            notif.icon = ev.data.params.value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
          end,
        })
      end,
    })

    require("lspconfig").elixirls.setup({
      cmd = { "elixir-ls" },
      filetypes = { "elixir", "eelixir", "heex", "elixirscript" },
    })

    require("lspconfig").lua_ls.setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = { disable = { "missing-fields" } },
        },
      },
    })
  end,
}

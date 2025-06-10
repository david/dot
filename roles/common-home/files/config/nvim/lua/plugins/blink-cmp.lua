
return {
  "saghen/blink.cmp",
  version = "*",
  opts = {
    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              highlight = function(ctx)
                local highlight = "BlinkCmpKind" .. ctx.kind

                if ctx.item.source_name == "LSP" then
                  local color_item =
                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end

                return highlight
              end,
              text = function(ctx)
                local icon = ctx.kind_icon

                if ctx.item.source_name == "LSP" then
                  local color_item =
                    require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr then
                    icon = color_item.abbr
                  end
                end

                return icon .. ctx.icon_gap
              end,
            },
          },
        },
      },
    },

    keymap = {
      ["<Up>"] = { "select_prev" },
      ["<Down>"] = { "select_next" },
      ["<Right>"] = { "select_and_accept" },
    },

    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}

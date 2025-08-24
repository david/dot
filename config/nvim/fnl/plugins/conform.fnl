(setup "stevearc/conform.nvim"
  {:opts
    {:formatters
      {:erb_format
        {:append_args [ "--print-width" "120" ]}} ;; same as rubocop
     :formatters_by_ft
       {:fennel [ "fnlfmt" ]
        :javascript [ "biome" ]
        :json [ "biome" ]
        :lua [ "stylua" ]
        :ruby [ "rubocop" ]
        "*" [ "trim_whitespace" ]}
     :format_after_save
       {:async true
        :lsp_format "fallback"
        :timeout_ms 500}
    :notify_no_formatters false}})

-- [nfnl] snippets/eruby.fnl
return {}, {s("%%", fmt("<% {} %>", {i(1)}, {delimiters = "{}"})), s("%=", fmt("<%= {} %>", {i(1)}, {delimiters = "{}"})), s("%e", t("<% end %>"))}

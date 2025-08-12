return {
  "gbprod/substitute.nvim",
  opts = {},
  keys = { {
    "gx",
    function()
      require("substitute.exchange").operator()
    end,
  } },
}

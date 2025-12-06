return {
  "nvim-neotest/neotest",
  config = function()
    return require("neotest").setup({
      adapters = { require("neotest-minitest"), require("neotest-rspec") },
      consumers = { require("neotest.consumers.overseer") },
    })
  end,
  keys = {
    { "<D-p>", function() require("neotest").run.run(vim.fn.getcwd()) end },
    { "<D-t>", "<cmd>Neotest output-panel<cr>" },
    {
      "<leader>rf",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Tests in File",
    },
    { "<leader>ot", "<cmd>Neotest output-panel<cr>", desc = "Show Test Output Panel" },
    {
      "<leader>rp",
      function() require("neotest").run.run(vim.fn.getcwd()) end,
      desc = "Tests in Project",
    },
    {
      "<leader>rr",
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Tests in File",
    },
    { "<leader>ru", function() require("neotest").run.run() end, desc = "Closer" },
  },
  cmd = { "Neotest" },
  dependencies = {
    "antoinemadec/FixCursorHold.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
    "stevearc/overseer.nvim",
    "zidhuss/neotest-minitest",
  },
}

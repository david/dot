-- [nfnl] fnl/plugins/overseer.fnl
return {
  "stevearc/overseer.nvim",
  opts = {
    component_aliases = {
      -- Most tasks are initialized with the default components
      default = {
        { "open_output", direction = "float", focus = true },
        { "display_duration", detail_level = 2 },
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_notify",
        { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" } },
      },
    },
    strategy = "terminal",
    task_win = {
      border = "none",
      padding = 3,
    },
  },
  keys = {
    { "<leader>ro", "<cmd>OverseerRun<cr>", desc = "Overseer" },
    { "<D-r>", "<cmd>OverseerRun<cr>" },
    { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Overseer" },
  },
}

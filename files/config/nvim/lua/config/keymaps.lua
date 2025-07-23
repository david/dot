-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "m", "q", { desc = "Toggle macro recording" })
map("n", "q", "<cmd>bd<cr>", { desc = "Close buffer" })
map("n", "Q", "<cmd>q<cr>", { desc = "Quit" })

map("n", "<D-/>", require("snacks").picker.grep, { desc = "Search text" })
map("n", "<D-f>", require("snacks").picker.files, { desc = "Find files" })

map({ "n", "i" }, "<M-,>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Switch to tab on the left" })
map({ "n", "i" }, "<M-.>", "<cmd>BufferLineCycleNext<cr>", { desc = "Switch to tab on the right" })

map({ "n", "i" }, "<D-C-,>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move tab left" })
map({ "n", "i" }, "<D-C-.>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move tab right" })

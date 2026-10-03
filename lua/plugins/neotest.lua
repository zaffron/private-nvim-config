require("neotest").setup({
  adapters = {
    require("neotest-jest"),
  },
})

vim.keymap.set("n", "<leader>ntr", "<cmd>Neotest run<cr>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>nto", "<cmd>Neotest output<cr>", { desc = "Test output" })
vim.keymap.set("n", "<leader>nts", "<cmd>Neotest summary<cr>", { desc = "Test summary" })

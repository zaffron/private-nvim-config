require("neotest").setup({
  adapters = {
    require("neotest-jest"),
  },
})

vim.keymap.set("n", "<leader>ntr", "<cmd>Neotest run<cr>")
vim.keymap.set("n", "<leader>nto", "<cmd>Neotest output<cr>")
vim.keymap.set("n", "<leader>nts", "<cmd>Neotest summary<cr>")

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "ibhagwan/fzf-lua", -- optional
    },
    config = function()
      vim.keymap.set("n", "<leader>N", ":Neogit<CR>", { silent = true })

      require("neogit").setup({})
    end,
  },
}

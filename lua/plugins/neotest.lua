return {
  "nvim-neotest/neotest",
  enabled = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    { "<leader>ntr", "<cmd>Neotest run<cr>" },
    { "<leader>nto", "<cmd>Neotest output<cr>" },
    { "<leader>nts", "<cmd>Neotest summary<cr>" },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest"),
      },
    })
  end,
}

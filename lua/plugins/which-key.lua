local wk = require("which-key")
wk.add({
  { "<leader>h", group = "harpoon", icon = "󰛢" },
  { "<leader>a", group = "avante", icon = "" },
  { "<leader>d", group = "diagnostics" },
  { "<leader>G", group = "git" },
  { "<leader>n", group = "neotest" },
  { "<leader>m", group = "mini", icon = "󰨆" },
  { "<leader>t", group = "toggle" },
  { "<leader>l", group = "lazy stuffs" },
  { "<leader>r", group = "rename stuffs", icon = "" },
  { "<leader>x", group = "emmet", icon = "󰯟" },
  { "<leader>v", group = "lsp", icon = "󰛦" },
  { "<leader>f", group = "fzf & format" },
})
wk.setup()

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-keys)" })

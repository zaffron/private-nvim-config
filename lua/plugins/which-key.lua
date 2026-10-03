local wk = require("which-key")
wk.add({
  { "<leader>d", group = "debug", icon = "" },
  { "<leader>G", group = "git" },
  { "<leader>n", group = "neotest" },
  { "<leader>nt", group = "test" },
  { "<leader>m", group = "mini", icon = "󰨆" },
  { "<leader>ms", group = "splitjoin" },
  { "<leader>t", group = "toggle" },
  { "<leader>l", group = "lazy stuffs" },
  { "<leader>r", group = "run", icon = "" },
  { "<leader>x", group = "emmet", icon = "󰯟" },
  { "<leader>v", group = "lsp", icon = "󰛦" },
  { "<leader>vc", group = "code" },
  { "<leader>vr", group = "rename & references" },
  { "<leader>vw", group = "workspace" },
  { "<leader>f", group = "fzf & format" },
  { "<leader>fG", group = "git" },
  { "<leader>fi", group = "grep filtered" },
  { "<leader>fm", group = "man" },
  { "ms", group = "surround", icon = "" },
})
wk.setup()

vim.keymap.set("n", "<leader>?", function()
  wk.show({ global = false })
end, { desc = "Buffer Local Keymaps (which-keys)" })

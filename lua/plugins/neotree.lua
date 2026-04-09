require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["\\"] = "close_window",
        ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
        ["l"] = "focus_preview",
        ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
        ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
      },
    },
    filtered_items = {
      visible = false,
      show_hidden_count = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        "node_modules",
        ".venv",
        ".git",
      },
      always_show = {
        ".gitignored",
      },
      always_show_by_pattern = {
        ".env*",
      },
      never_show = {
        ".git",
      },
    },
  },
})

vim.keymap.set("n", "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal", silent = true })

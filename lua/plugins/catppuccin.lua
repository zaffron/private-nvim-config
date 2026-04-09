require("catppuccin").setup({
  integrations = {
    treesitter = true,
    gitsigns = true,
    neotree = {
      enabled = false,
      show_root = true,
      transparent_panel = false,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
  },
})
vim.cmd.colorscheme("catppuccin-nvim")

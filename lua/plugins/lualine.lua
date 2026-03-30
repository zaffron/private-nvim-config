return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local catppuccin_palette = require("catppuccin.palettes").get_palette("mocha")

    require("lualine").setup({
      options = {
        theme = "catppuccin-nvim",
      },
      sections = {
        lualine_x = {
          {
            "lsp_status",
            icon = "", -- f013
            symbols = {
              -- Standard unicode symbols to cycle through for LSP progress:
              spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              -- Standard unicode symbol for when LSP is done:
              done = "✓",
              -- Delimiter inserted between LSP names:
              separator = " ",
            },
            -- List of LSP names to ignore (e.g., `null-ls`):
            ignore_lsp = {},
            color = { fg = catppuccin_palette.peach, bg = catppuccin_palette.surface1 },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = catppuccin_palette.peach, bg = catppuccin_palette.surface1 },
          },
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = catppuccin_palette.peach, bg = catppuccin_palette.surface1 },
          },
        },
      },
    })
  end,
}

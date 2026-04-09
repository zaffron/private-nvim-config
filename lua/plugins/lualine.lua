local catppuccin_palette = require("catppuccin.palettes").get_palette("mocha")

require("lualine").setup({
  options = {
    theme = "catppuccin-nvim",
  },
  sections = {
    lualine_x = {
      {
        "lsp_status",
        icon = "",
        symbols = {
          spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          done = "✓",
          separator = " ",
        },
        ignore_lsp = {},
        color = { fg = catppuccin_palette.peach, bg = catppuccin_palette.surface1 },
      },
      {
        function()
          local reg = vim.fn.reg_recording()
          if reg ~= "" then
            return "recording @" .. reg
          end
          return ""
        end,
        cond = function()
          return vim.fn.reg_recording() ~= ""
        end,
        color = { fg = catppuccin_palette.peach, bg = catppuccin_palette.surface1 },
      },
    },
  },
})

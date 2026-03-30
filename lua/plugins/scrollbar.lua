-- Very useful to show git changes and diagnostics on scrollbar but meh, I can just use my eyes
return {
  "petertriho/nvim-scrollbar",
  dependencies = { "catppuccin/nvim" },
  enabled = false,
  config = function()
    require("scrollbar").setup({
      handle = {
        color = require("catppuccin.palettes").get_palette("mocha").surface1,
      },
      marks = {
        Search = { color = require("catppuccin.palettes").get_palette("mocha").yellow },
        Error = { color = require("catppuccin.palettes").get_palette("mocha").red },
        Warn = { color = require("catppuccin.palettes").get_palette("mocha").peach },
        Info = { color = require("catppuccin.palettes").get_palette("mocha").blue },
        Hint = { color = require("catppuccin.palettes").get_palette("mocha").teal },
        Misc = { color = require("catppuccin.palettes").get_palette("mocha").mauve },
      },
      handlers = {
        diagnostic = true, -- Enable LSP diagnostic marks
        gitsigns = true,   -- Enable Git signs in scrollbar
      },
    })
  end,
}

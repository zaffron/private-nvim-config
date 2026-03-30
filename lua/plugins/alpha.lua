return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "󰍉  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
      dashboard.button("r", "  > Recent", ":FzfLua find_files<CR>"),
      dashboard.button("s", "  > Settings", ":cd ~/.config/nvim | e init.lua<CR>"),
      dashboard.button("u", "󰑓  > Update Plugins", ":Lazy update<CR>"),
      dashboard.button("q", "󰍃  > Quit NVIM", ":qa<CR>"),
    }

    local function footer()
      --@type lazy
      local lazy = require("lazy")
      local plugin_count = lazy.stats().count
      return {
        "",
        "",
        "              ⚡ Installed Plugins: " .. plugin_count,
        "",
        "------------------------------------------------------------",
        "Himmel tried, but he couldn't pull the sword from the stone.",
        "Even without the fabled sword, he managed to save the world.",
        "                   He was the real hero",
      }
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Type"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"

    alpha.setup(dashboard.opts)
  end,
}

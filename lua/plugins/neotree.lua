return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    cmd = "Neotree",
    keys = {
      { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
    },
    opts = {
      filesystem = {
        -- commands = {
        --   avante_add_files = function(state)
        --     local node = state.tree:get_node()
        --     local filepath = node:get_id()
        --     local relative_path = require("avante.utils").relative_path(filepath)

        --     local sidebar = require("avante").get()

        --     local open = sidebar:is_open()
        --     -- ensure avante sidebar is open
        --     if not open then
        --       require("avante.api").ask()
        --       sidebar = require("avante").get()
        --     end

        --     sidebar.file_selector:add_selected_file(relative_path)

        --     -- remove neo tree buffer
        --     if not open then
        --       sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
        --     end
        --   end,
        -- },
        window = {
          mappings = {
            ["\\"] = "close_window",
            -- ["oa"] = "avante_add_files",
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
    },
  },
}

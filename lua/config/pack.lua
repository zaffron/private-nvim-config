vim.pack.add({
  -- Shared dependencies
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Colorscheme
  { src = "https://github.com/catppuccin/nvim",                 name = "catppuccin" },

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },

  -- LSP & Mason
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",

  -- Completion
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1") },
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3')
  },

  -- UI
  "https://github.com/goolord/alpha-nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/lukas-reineke/indent-blankline.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/karb94/neoscroll.nvim",

  -- Editing
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/olrtg/nvim-emmet",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/supermaven-inc/supermaven-nvim",

  -- Git
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/kdheepak/lazygit.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/sindrets/diffview.nvim",

  -- Search
  "https://github.com/ibhagwan/fzf-lua",

  -- Language specific
  "https://github.com/mrcjkb/rustaceanvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/3rd/image.nvim",
  "https://github.com/brenoprata10/nvim-highlight-colors",
  "https://github.com/folke/todo-comments.nvim",

  -- Navigation
  "https://github.com/christoomey/vim-tmux-navigator",

  -- Testing
  "https://github.com/nvim-neotest/neotest",
  "https://github.com/nvim-neotest/neotest-jest",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/antoinemadec/FixCursorHold.nvim",

  -- Debugging
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/theHamsta/nvim-dap-virtual-text",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",
})

-- Immediate: colorscheme, treesitter, statusline, core UI
require("plugins.catppuccin")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.which-key")
require("plugins.indent-blankline")
require("plugins.vim-tmux-navigator")
require("plugins.neotree")

-- Deferred: load after UI is ready (completion, LSP, git, editing helpers)
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.schedule(function()
      require("plugins.mason")
      require("plugins.blink")
      require("plugins.fzf-lua")
      require("plugins.gitsigns")
      require("plugins.conform")
      require("plugins.autopairs")
      require("plugins.mini")
      require("plugins.supermaven")
      require("plugins.nvim-highlight-colors")
      require("plugins.todo-comments")
      require("plugins.neoscroll")
    end)
  end,
})

-- Alpha: only when opening nvim with no file arguments
vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    if vim.fn.argc() == 0 then
      vim.schedule(function()
        require("plugins.alpha")
      end)
    end
  end,
})

-- On-demand: load only when first used
local function on_cmd(cmds, plugin_mod)
  for _, cmd in ipairs(cmds) do
    vim.api.nvim_create_user_command(cmd, function(opts)
      vim.api.nvim_del_user_command(cmd)
      require(plugin_mod)
      vim.cmd(cmd .. " " .. (opts.args or ""))
    end, { nargs = "*", bang = true, complete = "file" })
  end
end

local function on_key(mode, lhs, plugin_mod)
  vim.keymap.set(mode, lhs, function()
    vim.keymap.del(mode, lhs)
    require(plugin_mod)
    local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
    vim.api.nvim_feedkeys(keys, "m", false)
  end, { desc = "lazy load " .. plugin_mod })
end

-- on_key("n", "\\", "plugins.neotree")
-- on_cmd({ "Neotree" }, "plugins.neotree")
on_cmd({ "LazyGit", "LazyGitCurrentFile" }, "plugins.lazygit")
on_key("n", "<leader>lg", "plugins.lazygit")
on_cmd({ "Neogit" }, "plugins.neogit")
on_key("n", "<leader>N", "plugins.neogit")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "jsx", "tsx", "vue", "svelte", "erb", "php" },
  once = true,
  callback = function()
    require("plugins.emmet")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "norg", "typst" },
  once = true,
  callback = function()
    require("plugins.image")
    require("plugins.markdown")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "lua", "python", "rust" },
  once = true,
  callback = function()
    require("plugins.neotest")
    require("plugins.dap")
  end,
})

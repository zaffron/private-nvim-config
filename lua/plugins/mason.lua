local cssfiles = {
  "tailwind.config.js",
  "tailwind.config.cjs",
  "tailwind.config.mjs",
  "tailwind.config.ts",
  "postcss.config.js",
  "postcss.config.cjs",
  "postcss.config.mjs",
  "postcss.config.ts",
}

return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  event = "VeryLazy",
  config = function()
    local ensure_installed = {
      -- LSP servers
      "eslint",
      "cssls",
      "cssmodules_ls",
      "emmet_ls",
      "lua_ls",
      "jsonls",
      "html",
      "pyright",
      "tailwindcss",
      -- "vtsls",
      "dockerls",
      "bashls",
      "marksman",
      "gopls",
      "tsgo",
      "tflint",
      "rust_analyzer",
      "terraformls",
      "qmlls",
    }
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    mason_lspconfig.setup({
      ensure_installed = ensure_installed,
      automatic_enable = {
        exclude = { "rust_analyzer" },
      },
    })

    vim.lsp.config("cssmodules_ls", {
      cmd = { "cssmodules-language-server", "--stdio" },

      filetypes = {
        "html",
        "css",
        "scss",
        "javascriptreact",
        "typescriptreact",
      },

      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local dir = vim.fs.dirname(fname)

        local root = vim.fs.find(cssfiles, { upward = true, path = dir })[1]

        if root then
          on_dir(vim.fs.dirname(root))
        end
      end,
    })

    vim.lsp.config("tailwindcss", {
      cmd = { "tailwindcss-language-server", "--stdio" },

      filetypes = {
        "html",
        "css",
        "scss",
        "javascriptreact",
        "typescriptreact",
      },

      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local dir = vim.fs.dirname(fname)

        local root = vim.fs.find(cssfiles, { upward = true, path = dir })[1]

        if root then
          on_dir(vim.fs.dirname(root))
        end
      end,
    })

    vim.lsp.config("pyright", {
      settings = {
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfi.json",
        },
        python = {
          venvPath = ".",
          venv = ".venv",
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })
  end,
}

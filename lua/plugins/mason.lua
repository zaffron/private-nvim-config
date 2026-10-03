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

local ensure_installed = {
  "eslint",
  "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "lua_ls",
  "jsonls",
  "html",
  "pyright",
  "tailwindcss",
  "dockerls",
  "bashls",
  "marksman",
  "gopls",
  "tsc",
  "tflint",
  "rust_analyzer",
  "terraformls",
  "qmlls",
  "buf_ls",
}

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
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

-- tsgo (@typescript/native-preview) ships an extensionless ESM entry point,
-- which Node < 20 cannot execute (ERR_UNKNOWN_FILE_EXTENSION). Projects that pin
-- an old Node via .nvmrc (e.g. 18.x) make fnm hand nvim that Node, crashing the
-- server on startup. Force tsgo to run under a modern Node without touching the
-- project's runtime Node.
-- local function modern_node()
--   local candidates = {
--     vim.fn.expand("~/.local/share/fnm/aliases/default/bin/node"),
--     "/opt/homebrew/bin/node",
--   }
--   for _, node in ipairs(candidates) do
--     if vim.fn.executable(node) == 1 then
--       return node
--     end
--   end
--   return "node"
-- end
--
-- vim.lsp.config("tsgo", {
--   cmd = function(dispatchers, config)
--     local script = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/tsgo"
--     if not (script and vim.fn.executable(script) == 1) then
--       script = vim.fn.exepath("tsc")
--     end
--     return vim.lsp.rpc.start({ modern_node(), script, "--lsp", "--stdio" }, dispatchers)
--   end,
-- })

vim.lsp.config("pyright", {
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
  },
  settings = {
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

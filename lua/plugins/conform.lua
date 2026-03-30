local webdev_opts = {
  stop_after_first = true,
  "prettierd",
  "prettier",
}

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>ff",
      function()
        require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 500 })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = webdev_opts,
      typescript = webdev_opts,
      typescriptreact = webdev_opts,
      javascriptreact = webdev_opts,
      css = webdev_opts,
      html = webdev_opts,
      gotmpl = webdev_opts,
      json = webdev_opts,
      markdown = webdev_opts,
      go = { "gofmt", "goimports" },
      ["markdown.mdx"] = { "prettierd", "markdownlint-cli2", "markdown-toc" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_format = true, async = false },
    -- Customize formatters
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
      ["markdownlint-cli2"] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == "markdownlint"
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    notify_on_error = true,
    notify_no_formatters = true,
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

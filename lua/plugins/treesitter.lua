local languages = {
  "http",
  "python",
  "javascript",
  "typescript",
  "toml",
  "json",
  "gitignore",
  "yaml",
  "markdown",
  "bash",
  "tsx",
  "css",
  "html",
  "go",
  "gotmpl",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      local function have(feature)
        -- Placeholder function to check for feature presence
        -- Replace with actual logic as needed
        return vim.fn.executable(feature) == 1
      end

      local function add(lang)
        if type(opts.ensure_installed) == "table" then
          table.insert(opts.ensure_installed, lang)
        end
      end

      vim.filetype.add({
        extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
        filename = {
          ["vifmrc"] = "vim",
        },
        pattern = {
          [".*/waybar/wallust/.*"] = "jsonc",
          [".*/waybar/style/.*"] = "css",
          [".*/waybar/configs/.*"] = "jsonc",
          [".*/waybar/[^/]+"] = "jsonc",
          [".*/kitty/.+%.conf"] = "kitty",
          [".*/hypr/.+%.conf"] = "hyprlang",
        },
      })

      -- vim.treesitter.language.register("bash", "kitty")

      add("git_config")

      if have("hypr") then
        add("hyprlang")
      end

      if have("rofi") or have("wofi") then
        add("rasi")
      end
    end,
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          local ok = pcall(vim.treesitter.start, args.buf, lang)
          if ok then
            vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldmethod = 'expr'
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })


      vim.filetype.add({
        pattern = {
          ["%.env"] = "conf",
          ["%.env%.[%w_.-]+"] = "conf",
        },
      })
    end,
    -- vim.api.nvim_set_hl(0, "@comment", { italic = true }),
    -- vim.api.nvim_set_hl(0, "@keyword", { italic = true }),
    -- vim.api.nvim_set_hl(0, "@type", { italic = true }),
    -- vim.api.nvim_set_hl(0, "@storageclass", { italic = true }),
  },
}

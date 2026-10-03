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
  "git_config",
  "proto"
}

-- vim.filetype.add({
--   extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
--   filename = {
--     ["vifmrc"] = "vim",
--   },
--   pattern = {
--     [".*/waybar/wallust/.*"] = "jsonc",
--     [".*/waybar/style/.*"] = "css",
--     [".*/waybar/configs/.*"] = "jsonc",
--     [".*/waybar/[^/]+"] = "jsonc",
--     [".*/kitty/.+%.conf"] = "kitty",
--     [".*/hypr/.+%.conf"] = "hyprlang",
--   },
-- })
--
-- if vim.fn.executable("hypr") == 1 then
--   table.insert(languages, "hyprlang")
-- end
--
-- if vim.fn.executable("rofi") == 1 or vim.fn.executable("wofi") == 1 then
--   table.insert(languages, "rasi")
-- end

local treesitter = require("nvim-treesitter")
treesitter.install(languages)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft
    local ok = pcall(vim.treesitter.start, args.buf, lang)
    if ok then
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
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

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

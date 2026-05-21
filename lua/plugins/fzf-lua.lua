local fzf = require("fzf-lua")

local function file_exists(path)
  local stat = vim.uv.fs_stat(path)
  return stat and stat.type == "file"
end

local function find_root_with_package_json()
  local cwd = vim.fn.getcwd()
  while cwd ~= "/" do
    if file_exists(cwd .. "/package.json") then
      return cwd
    end
    cwd = vim.fn.fnamemodify(cwd, ":h")
  end
  return nil
end

local function live_grep_with_ignore(extra_globs)
  local root = find_root_with_package_json()
  if not root then
    fzf.live_grep()
    return
  end
  local cmd = {
    "rg",
    "--color=always",
    "--column",
    "--line-number",
    "--no-heading",
    "--smart-case",
    "--hidden",
    "--glob", "!node_modules/**",
    "--glob", "!.git/**",
    "--glob", "!dist/**",
    "--glob", "!build/**",
  }
  for _, g in ipairs(extra_globs or {}) do
    table.insert(cmd, "--glob")
    table.insert(cmd, vim.fn.shellescape(g))
  end
  fzf.live_grep({
    cwd = root,
    cmd = table.concat(cmd, " "),
  })
end

fzf.setup({
  winopts = {
    height = 0.9,
    width = 0.9,
    border = "rounded",
    zindex = 100,
  },
  files = {
    multiprocess = true,
    git_icons = false,
    file_icons = true,
    color_icons = true,
    find_opts = [[-type f -not -path '*/\.git/*' -not -path '*/node_modules/*' -not -path '*/dist/*']],
    rg_opts = [[--color=never --hidden --files -g "!.git"]],
    fd_opts = [[--type f --strip-cwd-prefix --hidden -I --exclude .git --exclude node_modules --exclude .venv]],
    dir_opts = [[/s/b/a:-d]],
  },
  grep = {
    actions = { ["ctrl-q"] = { fn = fzf.actions.file_sel_to_qf, prefix = "select-all" } },
  },
})
fzf.register_ui_select()

vim.keymap.set("n", "<C-p>", fzf.files, { desc = "fzf-lua find files" })
vim.keymap.set("n", "<leader>fg", function() live_grep_with_ignore() end, { desc = "fzf-lua live grep (smart ignore)" })
vim.keymap.set("n", "<leader>fit", function()
  live_grep_with_ignore({
    "!*.{spec,test}.{ts,tsx,js,jsx}",
    "!**/__tests__/**",
  })
end, { desc = "fzf-lua live grep (no specs/tests)" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "fzf-lua buffers" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "fzf-lua help tags" })
vim.keymap.set("n", "<leader>fGb", fzf.git_branches, { desc = "fzf-lua git branches" })
vim.keymap.set("n", "<leader>fmp", fzf.man_pages, { desc = "fzf-lua man pages" })
vim.keymap.set("n", "<leader>vca", fzf.lsp_code_actions, { desc = "LSP Code Action" })

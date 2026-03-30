--
-- Run in node
-- vim.keymap.set("n", "<leader>rin", function()
--   vim.cmd("w") -- save file first
--   vim.cmd("!node %")
-- end, { desc = "Run current file with Node" })


local float_term_buf = nil
local float_term_win = nil

local function close_float()
  if float_term_win and vim.api.nvim_win_is_valid(float_term_win) then
    vim.api.nvim_win_close(float_term_win, true)
    float_term_win = nil
    float_term_buf = nil
  end
end

local function run_node()
  -- Ensure file has a name
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("Save the file first!")
    return
  end

  vim.cmd("write")
  close_float()

  float_term_buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.3)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  float_term_win = vim.api.nvim_open_win(float_term_buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  })

  -- Modern replacement for termopen
  vim.fn.jobstart({ "node", file }, {
    term = true,
  })

  vim.cmd("startinsert")

  -- q to close
  vim.keymap.set("n", "q", close_float, { buffer = float_term_buf, silent = true })
  vim.keymap.set("t", "q", function()
    vim.cmd("stopinsert")
    close_float()
  end, { buffer = float_term_buf, silent = true })
end

vim.keymap.set("n", "<leader>rin", run_node, { desc = "Run current JS file" })

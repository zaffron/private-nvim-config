require("mini.surround").setup({
  custom_surroundings = nil,
  highlight_duration = 300,
  mappings = {
    add = "msa",
    delete = "msd",
    find = "msf",
    find_left = "msF",
    highlight = "msh",
    replace = "msr",
    update_n_lines = "msn",
    suffix_last = "l",
    suffix_next = "n",
  },
  n_lines = 20,
  respect_selection_type = false,
  search_method = "cover",
  silent = false,
})

local miniSplitJoin = require("mini.splitjoin")
miniSplitJoin.setup({
  mappings = { toggle = "" },
})
vim.keymap.set({ "n", "x" }, "<leader>msj", function()
  miniSplitJoin.join()
end, { desc = "Join arguments" })
vim.keymap.set({ "n", "x" }, "<leader>mse", function()
  miniSplitJoin.split()
end, { desc = "Split arguments" })

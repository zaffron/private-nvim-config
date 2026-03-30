-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    -- setup autopairs
    autopairs.setup({
      check_ts = true, -- treesitter enabled
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in js template_string treesitter nodes,
        java = false, -- don't check treesitter on java
      },
    })
  end,
}

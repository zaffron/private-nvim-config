-- Someday, I will avoid mason lsp configs but man, I am not that teenager anymore who wants to gets involved in maintaining LSP dependencies hell
-- vim.lsp.enable({
--   "cssls",
--   "cssmodules",
--   "emmet_ls",
--   "eslint",
--   "html",
--   "json",
--   "lua_ls",
--   "pyright",
--   "tailwindcss",
--   "vtsls",
-- })

-- Blink provides more features so I will just ignore this for now
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client then
-- 			if client:supports_method("textDocument/completion") then
-- 				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
-- 			end
-- 		end
-- 	end,
-- })

vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true,
  -- Alternatively, customize specific options
  virtual_lines = {
    -- Only show virtual line diagnostics for the current cursor line
    current_line = true,
  },
})

local map = vim.keymap.set
map("n", "gr", vim.lsp.buf.references, { desc = "LSP Goto Reference" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP Goto Definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = "LSP Workspace Symbol" })
map("n", "<leader>vd", vim.diagnostic.setloclist, { desc = "LSP Show Diagnostics" })
--map("n", "<leader>vca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", "<leader>vce", function()
  vim.diagnostic.open_float(nil, { focusable = false })
end, { desc = "Show error message" })
map("n", "<leader>vrr", vim.lsp.buf.references, { desc = "LSP References" })
map("n", "<leader>vrn", vim.lsp.buf.rename, { desc = "LSP Rename" })
map("i", "<C-h>", vim.lsp.buf.signature_help, { noremap = true, desc = "LSP Signature Help" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev Diagnostic" })

vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next Diagnostic" })

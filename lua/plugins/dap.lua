local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

local function get_args()
  local args_string = vim.fn.input("Args: ")
  return vim.split(args_string, " +")
end

local dap = require("dap")
local dapui = require("dapui")

-- DAP UI setup
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.9 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 80,
      position = "right",
    },
    {
      elements = { "repl", "console" },
      size = 0.25,
      position = "bottom",
    },
  },
  floating = {
    border = "single",
    mappings = { close = { "q", "<Esc>" } },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- DAP virtual text
require("nvim-dap-virtual-text").setup({})

-- Highlight stopped line
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

-- Debug signs
local signs = {
  DapBreakpoint = { text = "●", texthl = "DiagnosticError" },
  DapStopped = { text = "▶", texthl = "DiagnosticInfo" },
  DapBreakpointRejected = { text = "○", texthl = "DiagnosticWarn" },
  DapBreakpointCondition = { text = "●", texthl = "DiagnosticHint" },
}
for name, sign in pairs(signs) do
  vim.fn.sign_define(name, {
    text = sign.text,
    texthl = sign.texthl,
    linehl = "",
    numhl = "",
  })
end

-- Mason DAP setup
require("mason-nvim-dap").setup({
  ensure_installed = { "debugpy", "delve", "js-debug-adapter" },
  automatic_installation = true,
})

-- JS/TS debugging adapter (pwa-node)
dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = {
      vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
      "${port}",
    },
  },
}

-- Go debugging adapter (delve)
dap.adapters.go = function(callback, config)
  callback({
    type = "server",
    host = "127.0.0.1",
    port = config.port or 38697,
    executable = {
      command = "dlv",
      args = {
        "dap",
        "-l",
        "127.0.0.1:" .. (config.port or 38697),
      },
    },
  })
end

dap.configurations.go = {
  {
    type = "go",
    name = "[Go] Debug file",
    request = "launch",
    program = "${file}",
  },
  {
    type = "go",
    name = "[Go] Debug package",
    request = "launch",
    program = "${fileDirname}",
  },
  {
    type = "go",
    name = "[Go] Debug test (file)",
    request = "launch",
    mode = "test",
    program = "${file}",
  },
  {
    type = "go",
    name = "[Go] Debug test (package)",
    request = "launch",
    mode = "test",
    program = "${fileDirname}",
  },
  {
    type = "go",
    name = "[Go] Attach to running TUI",
    request = "attach",
    mode = "remote",
    port = 38697,
    host = "127.0.0.1",
  },
  {
    type = "go",
    name = "[Go] Attach to process",
    request = "attach",
    processId = require("dap.utils").pick_process,
  },
}

-- Configure JS/TS languages
for _, language in ipairs(js_based_languages) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require("dap.utils").pick_process,
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Auto attach",
      port = 9229,
      cwd = vim.fn.getcwd(),
      processId = function()
        local output = vim.fn.system("ps -ax -o pid=,command= | grep 'start:debug' | grep -v grep")
        for pid in output:gmatch("(%d+)%s") do
          return tonumber(pid)
        end
      end,
      skipFiles = { "<node_internals>/**", "node_modules/**" },
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Run npm start:debug",
      runtimeExecutable = "npm",
      runtimeArgs = { "run", "start:debug" },
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
  }
end

-- Keymaps
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Conditional Breakpoint" })
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", function()
  dap.continue()
end, { desc = "Start/Continue" })
vim.keymap.set("n", "<leader>da", function()
  dap.continue({ before = get_args })
end, { desc = "Run with Args" })
vim.keymap.set("n", "<leader>dO", function()
  dap.step_over()
end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", function()
  dap.step_into()
end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", function()
  dap.step_out()
end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dt", function()
  dap.terminate()
end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dr", function()
  dap.repl.toggle()
end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "Inspect Variable" })
vim.keymap.set("n", "<leader>dQ", function()
  dap.terminate()
  dapui.close()
end, { desc = "Terminate Debug + Close UI" })

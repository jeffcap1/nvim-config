local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

-- 1. setup dap
local dap_core = {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- virtual text for the debugger
    "theHamsta/nvim-dap-virtual-text",
  },
}

-- stylua: ignore
dap_core.keys = {
  { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
  { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
  { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
  { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
  { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
  { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
  { "<leader>dj", function() require("dap").down() end, desc = "Down" },
  { "<leader>dk", function() require("dap").up() end, desc = "Up" },
  { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
  { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
  { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
  { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
  { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
  { "<leader>ds", function() require("dap").session() end, desc = "Session" },
  { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
}
-- stylua: ignore end

dap_core.config = function()
  local icons = require("user.icons")

  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

  for name, value in pairs(icons.dap) do
    local text = ""
    local texthl = "DiagnosticInfo"
    local linehl = nil
    local numhl = nil

    if type(value) == "table" then
      text = value[1]
      texthl = value[2] or texthl
      linehl = value[3]
      numhl = value[3]
    else
      text = value
    end

    vim.fn.sign_define("Dap" .. name, { text = text, texthl = texthl, linehl = linehl, numhl = numhl })
  end

  -- setup dap config by VsCode launch.json file
  local vscode = require("dap.ext.vscode")
  local json = require("plenary.json")
  ---@diagnostic disable-next-line: duplicate-set-field
  vscode.json_decode = function(str)
    return vim.json.decode(json.json_strip_comments(str))
  end
end

-- 2. setup dap-ui
local dap_ui = {
  "rcarriga/nvim-dap-ui",
  lazy = true,
  dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      { "<leader>dw", function() require("dapui").elements.watches.add() end, "Add Watch", },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  -- stylua: ignore end
  opts = {},
  config = function(_, opts)
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup(opts)
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
  end,
}

-- 3. setup mason.nvim integration
local dap_mason = {
  "jay-babu/mason-nvim-dap.nvim",
  lazy = true,
  dependencies = "mason.nvim",
  cmd = { "DapInstall", "DapUninstall" },
  opts = {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_installation = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = USERS_DAP_SERVERS,
  },
  -- mason-nvim-dap is loaded when nvim-dap loads
  config = function() end,
}

-- 4. load dap settings for each supported langauge
local lang_setup = {}
for _, file in ipairs(vim.fn.readdir(vim.fn.expand("~/.config/nvim/lua/user/dap_settings"))) do
  if file:match("%.lua") then
    table.insert(lang_setup, { import = "user.dap_settings." .. file:sub(1, -5) })
  end
end

-- 5. return all plugins
return {
  dap_core,
  dap_ui,
  dap_mason,
  lang_setup,
}

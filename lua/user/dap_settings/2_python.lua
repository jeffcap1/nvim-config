return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
    config = function()
      local dap = require("dap")
      if vim.fn.has("win32") == 1 then
        require("dap-python").setup(GET_PKG_PATH("debugpy", "venv/Scripts/pythonw.exe"))
      else
        require("dap-python").setup(GET_PKG_PATH("debugpy", "venv/bin/python"))
      end

      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
        },
      }
    end,
  },
}

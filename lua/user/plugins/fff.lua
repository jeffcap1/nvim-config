local M = {
  "dmtrKovalenko/fff.nvim",
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require("fff.download").download_or_build_binary()
  end,
  lazy = false, -- the plugin lazy-initialises itself
}

M.opts = {
  prompt_vim_mode = true,
  follow_symlinks = false,
  layout = {
    prompt_position = "top", -- or 'top'
  },
}

-- stylua: ignore
M.keys = {
    { "<leader>ff", function() require('fff').find_files() end, desc = 'FFFind files' },
    { "<leader>ft", function() require('fff').live_grep() end, desc = 'LiFFFe grep' },
    { "<leader>fr", function() require('fff').resume() end, desc = 'FFF resume' },
    { "<leader>fc", function() require('fff').live_grep({ query = vim.fn.expand('<cword>') }) end, desc = "Grep current word" },
    { "<leader>fF", function()
        local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if root then
          require("fff").find_files_in_dir(root)
        end
      end,
      desc = "Find files (git root)"
    },
    { "<leader>fv", function()
        local text = table.concat(vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos(".")), "\n")
        require("fff").live_grep({ query = text })
      end,
      mode = "v",
      desc = "Grep visual selection"
    },
}
-- stylua: ignore end

return M

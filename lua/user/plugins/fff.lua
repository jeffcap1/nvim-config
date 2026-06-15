local M = {
  "dmtrKovalenko/fff.nvim",
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require("fff.download").download_or_build_binary()
  end,
  lazy = false, -- the plugin lazy-initialises itself
}

M.opts = {
  prompt = "> ",
  layout = {
    prompt_position = "top", -- or 'top'
  },
}

-- stylua: ignore
M.keys = {
    { "ff", function() require('fff').find_files() end, desc = 'FFFind files' },
    { "ft", function() require('fff').live_grep() end, desc = 'LiFFFe grep' },
    { "fz",
      function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end,
      desc = 'Live fffuzy grep',
    },
    { "fc",
      function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end,
      desc = 'Search current word',
    },
}
-- stylua: ignore end

return M

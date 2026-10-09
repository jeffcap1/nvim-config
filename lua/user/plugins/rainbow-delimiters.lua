local M = {
  "hiphish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

function M.init()
  vim.g.rainbow_delimiters = {
    -- Only real file buffers. Picker previews (fff, snacks) set the previewed file's
    -- filetype on a `nofile` scratch buffer that is wiped on close; rainbow-delimiters
    -- re-highlighting during that treesitter detach recursed into a stack overflow
    -- inside fff's nvim_win_close (fff/picker_ui/layout_manager.lua:96).
    condition = function(bufnr)
      return vim.bo[bufnr].buftype == ""
    end,
  }
end

return M

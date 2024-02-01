local M = {
  "kevinhwang91/nvim-bqf",
  event = "VeryLazy",
}

function M.config()
  require("bqf").setup({
    auto_enable = true,
    magic_window = true,
    auto_resize_height = false,
    preview = {
      auto_preview = false,
      border = "rounded",
      show_scroll_bar = true,
      show_title = true,
      win_height = 15,
      win_vheight = 15,
      winblend = 12,
      buf_label = true,
      delay_syntax = 50,
      wrap = false,
      should_preview_cb = function(bufnr)
        local ret = true
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        local fsize = vim.fn.getfsize(bufname)
        if fsize > 100 * 1024 then
          -- skip file size greater than 100k
          ret = false
        elseif bufname:match("^fugitive://") then
          -- skip fugitive buffer
          ret = false
        end
        return ret
      end,
    },
    func_map = {
      tab = "t",
      openc = "o",
      drop = "O",
      split = "s",
      vsplit = "v",
      stoggleup = "M",
      stoggledown = "m",
      stogglevm = "m",
      filterr = "f",
      filter = "F",
      prevhist = "<",
      nexthist = ">",
      sclear = "c",
      ptoggleitem = "p",
      ptoggleauto = "a",
      ptogglemode = "P",
    },
    filter = {
      fzf = {
        action_for = {
          ["ctrl-t"] = "tabedit",
          ["ctrl-v"] = "vsplit",
          ["ctrl-x"] = "split",
          ["ctrl-q"] = "signtoggle",
          ["ctrl-c"] = "closeall",
        },
        extra_opts = {
          description = "Extra options for fzf",
          default = { "--bind", "ctrl-o:toggle-all" },
        },
      },
    },
  })
end

return M

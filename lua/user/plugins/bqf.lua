local M = {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  dependencies = {
    "junegunn/fzf.vim",
    "junegunn/fzf",
  },
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
        local fpath = vim.api.nvim_buf_get_name(bufnr)
        -- Use vim.uv (libuv) for performance
        local ok, stats = pcall(vim.uv.fs_stat, fpath)

        if ok and stats and stats.size > 100 * 1024 then
          ret = false
        elseif fpath:match("^fugitive://") then
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
          ["c-t"] = "tabedit",
          ["c-v"] = "vsplit",
          ["c-x"] = "split",
          ["c-q"] = "signtoggle",
          ["c-c"] = "closeall",
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

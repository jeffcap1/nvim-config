local M = {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
}

function M.config()
  require("ufo").setup({
    open_fold_hl_timeout = 100,
    close_fold_kinds = { "comment" },
    enable_get_fold_virt_text = true,
    preview = {
      description = [[Configure the options for preview window and remap the keys for current
                    buffer and preview buffer if the preview window is displayed.
                    Never worry about the users's keymaps are overridden by ufo, ufo will save
                    them and restore them if preview window is closed.]],
      win_config = {
        -- border = {
        --   description = [[The border for preview window,
        --             `:h nvim_open_win() | call search('border:')`]],
        --   default = "rounded",
        -- },
        winblend = {
          description = [[The winblend for preview window, `:h winblend`]],
          default = 12,
        },
        winhighlight = {
          description = [[The winhighlight for preview window, `:h winhighlight`]],
          default = "Normal:Normal",
        },
        maxheight = {
          description = [[The max height of preview window]],
          default = 20,
        },
      },
      mappings = {
        description = [[The table for {function = key}]],
        default = [[see ###Preview function table for detail]],
      },
    },
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  })
end

return M

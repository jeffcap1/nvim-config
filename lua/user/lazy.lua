-- setup Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = LAZY_PLUGIN_SPEC,
  install = {
    colorscheme = { "catppuccin", "default" },
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = false, -- notification when plugins have updates
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  rocks = {
    enabled = true, -- keep rocks support
    hererocks = true, -- Lazy will auto-install a local Lua 5.1 + luarocks
  },
})

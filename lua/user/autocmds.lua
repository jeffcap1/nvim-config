-- highlight yanked text
local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- alternate: "Visual"
      timeout = 200,
    })
  end,
})

-- remove whitespace on save
local whitespace_group = vim.api.nvim_create_augroup("BufWhiteSpace", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = whitespace_group,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- change cursor to vertical blinking bar when leaving neovim
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  callback = function()
    vim.opt.guicursor = "a:ver1-blinkon1"
  end,
})

-- stop auto commenting new lines when hitting o or O
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

-- allow quitting with q in certain contexts
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "typescript-errors",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- set options for filetypes
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- fix context issue when not completeing a snippet
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      -- ask maintainer for option to make this silent
      -- luasnip.unlink_current()
      vim.cmd([[silent! lua require("luasnip").unlink_current()]])
    end
  end,
})

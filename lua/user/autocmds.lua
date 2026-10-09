local function augroup(name)
  return vim.api.nvim_create_augroup("local_user_" .. name, { clear = true })
end

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch", -- alternate: "Visual"
      timeout = 200,
    })
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- stop auto commenting new lines when hitting o or O
--[[ vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
}) ]]

-- allow quitting with q in certain contexts
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    -- built-in
    "checkhealth",
    "git",
    "help",
    "man",
    "netrw",
    "qf",
    -- plugins
    "dap-float", -- nvim-dap
    "gitsigns-blame", -- gitsigns
    "oil", -- oil.nvim
    "typescript-errors", -- better-ts-errors
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- set options for filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- set options for markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
  end,
})

-- leave the snippet session when exiting insert/select mode so jumps don't
-- resurrect a stale snippet later (only if LuaSnip is already loaded)
vim.api.nvim_create_autocmd("ModeChanged", {
  group = augroup("luasnip_unlink"),
  pattern = { "s:n", "i:*" },
  callback = function(event)
    local luasnip = package.loaded["luasnip"]
    if luasnip and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
      luasnip.unlink_current()
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

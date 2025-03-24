vim.g.mapleader = " "

-- tabs
vim.opt.tabstop = 2 -- Insert 2 spaces for a tab
vim.opt.softtabstop = 2 -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2 -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.shiftround = true -- Round indent

-- line numbers
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative Line numbers
vim.opt.signcolumn = "yes" -- Always sets room for 3 digits in line numbers

-- highlights
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- splits
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

-- pop up menu settings
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 0 -- pop up menu transparency

-- backups and swap files
vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false -- creates a swapfile
vim.opt.undofile = true -- enable persistent undo

-- vim status settings
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore, handled by lualine
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
-- vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files and "" in json files

-- mouse model
vim.opt.mousemodel = "extend"

-- search
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- smart case

-- show invisible characters
vim.opt.listchars = "eol:↵,tab:| ,trail:~,extends:>,precedes:<"
vim.opt.list = true
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({ stl = " " })
vim.opt.shortmess:append("c")

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- general settings
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.cursorline = true -- highlight the current line
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2
vim.opt.isfname:append("@-@")
vim.opt.wrap = false -- display lines as one long line
vim.opt.updatetime = 50 -- faster updates
-- vim.opt.colorcolumn = { "80", "120", "160" }
vim.opt.ruler = true
vim.opt.title = true
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  vim.opt.foldmethod = "expr"
  vim.opt.foldtext = ""
else
  vim.opt.foldmethod = "indent"
  vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

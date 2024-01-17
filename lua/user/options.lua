vim.g.mapleader = " "

-- tabs
vim.opt.tabstop = 2      -- Insert 2 spaces for a tab
vim.opt.softtabstop = 2  -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 2   -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true  -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true -- Converts tabs to spaces

-- line numbers
vim.opt.number = true         -- Line numbers
vim.opt.relativenumber = true -- Relative Line numbers
vim.opt.signcolumn = "yes"    -- Always sets room for 3 digits in line numbers

-- highlights
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- splits
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window

-- pop up menu settings
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.pumblend = 10

-- backups and swap files
vim.opt.backup = false      -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false    -- creates a swapfile
vim.opt.undofile = true     -- enable persistent undo

-- vim status settings
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore, handled by lualine
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
-- vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)

-- markdown
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files

-- search
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- smart case

-- folding
-- vim.opt.foldmethod = "syntax"
-- vim.opt.foldlevel = 2
vim.o.foldmethod = "indent" -- '0' is not bad
vim.o.foldcolumn = "1"      -- '0' is not bad
vim.o.foldlevel = 99        -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- show invisible characters
-- vim.opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
-- vim.opt.listchars = "tab:>·,trail:~,extends:>,precedes:<,space:·"
-- vim.opt.listchars = "tab:⇥¬¬,trail:·,extends:>,precedes:<,space:·"
vim.opt.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"
vim.opt.list = true
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append({
  stl = " ",
})
vim.opt.shortmess:append("c")

-- general settings
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.cursorline = true    -- highlight the current line
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.wrap = false    -- display lines as one long line
vim.opt.updatetime = 50 -- faster updates
vim.opt.colorcolumn = { "80", "120", "160" }
vim.opt.ruler = true
vim.opt.title = true

local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h")
keymap("n", "<m-j>", "<C-w>j")
keymap("n", "<m-k>", "<C-w>k")
keymap("n", "<m-l>", "<C-w>l")
keymap("n", "<m-tab>", "<c-6>")

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- visually move lines
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- fixes pasting so it keeps the current register
keymap("x", "p", '"_dP')

-- delete won't copy to register
keymap({ "n", "v" }, "<leader>d", '"_d')

-- allows copying to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y')
keymap("v", "<leader>Y", '"+Y')

-- better defaults for Y and J
keymap("n", "Y", "yg$")
keymap("n", "J", "mzJ`z")

-- better navigation, keep content in the center of the screen
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz")
keymap("n", "#", "#zz")
keymap("n", "g*", "g*zz")
keymap("n", "g#", "g#zz")

-- add context menu
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]])
keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
keymap("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- working with multi-line
keymap({ "n", "x" }, "j", "gj")
keymap({ "n", "x" }, "k", "gk")
keymap("n", "<leader>w", ":lua vim.wo.wrap = not vim.wo.wrap<CR>")

-- toggle relative numbers (easier for pairing)
keymap("n", "<leader>rn", ":lua vim.wo.rnu = not vim.wo.rnu<CR>")

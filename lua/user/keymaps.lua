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
keymap("v", "J", ":m '>+1<cr>gv=gv")
keymap("v", "K", ":m '<-2<cr>gv=gv")

-- fixes pasting so it keeps the current register
keymap("x", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without yanking" })

-- delete won't copy to register
keymap({ "n", "v" }, "<leader>d", '"_d', { noremap = true, silent = true, desc = "Delete without yanking" })

-- allows copying to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })

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
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<cr>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<cr>]])
keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>", { silent = true })
keymap("n", "<Tab>", "<cmd>:popup mousemenu<cr>", { silent = true })

-- working with multi-line
keymap({ "n", "x" }, "j", "gj")
keymap({ "n", "x" }, "k", "gk")
keymap(
  "n",
  "<leader>w",
  "<cmd>lua vim.wo.wrap = not vim.wo.wrap<cr>",
  { noremap = true, silent = true, desc = "Toggle word wrap" }
)

-- toggle relative numbers (easier for pairing)
keymap(
  "n",
  "<leader>rn",
  "<cmd>lua vim.wo.rnu = not vim.wo.rnu<cr>",
  { noremap = true, silent = true, desc = "Toggle rnu" }
)

keymap("n", "<leader><leader>c", "<cmd>source ~/.config/nvim/init.lua<cr>", { noremap = true, desc = "Reload Config" })

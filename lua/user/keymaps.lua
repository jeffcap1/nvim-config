local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", XTND({ desc = "Move to window left" }))
keymap("n", "<m-j>", "<C-w>j", XTND({ desc = "Move to window down" }))
keymap("n", "<m-k>", "<C-w>k", XTND({ desc = "Move to window up" }))
keymap("n", "<m-l>", "<C-w>l", XTND({ desc = "Move to window right" }))
keymap("n", "<m-tab>", "<c-6>")

-- Stay in indent mode
keymap("v", "<", "<gv", XTND({ desc = "Indent left" }))
keymap("v", ">", ">gv", XTND({ desc = "Indent right" }))

-- visually move lines
keymap("v", "<c-j>", ":m '>+1<cr>gv=gv", XTND({ desc = "Move line down" }))
keymap("v", "<c-k>", ":m '<-2<cr>gv=gv", XTND({ desc = "Move line up" }))

-- fixes pasting so it keeps the current register
keymap("x", "p", '"_dP', XTND({ desc = "Paste without yanking" }))

-- delete won't copy to register
keymap({ "n", "v" }, "<leader>d", '"_d', XTND({ desc = "Delete without yanking" }))

-- allows copying to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', XTND({ desc = "Yank to clipboard" }))

-- better defaults for Y and J
keymap("n", "Y", "yg$", XTND({ desc = "Yank to end of line" }))
keymap("n", "J", "mzJ`z", XTND({ desc = "Join lines" }))

-- better navigation, keep content in the center of the screen
keymap("n", "<C-d>", "<C-d>zz", XTND({ desc = "Scroll down" }))
keymap("n", "<C-u>", "<C-u>zz", XTND({ desc = "Scroll up" }))
keymap("n", "n", "nzz", XTND({ desc = "Next match" }))
keymap("n", "N", "Nzz", XTND({ desc = "Previous match" }))
keymap("n", "*", "*zz", XTND({ desc = "Next match" }))
keymap("n", "#", "#zz", XTND({ desc = "Previous match" }))
keymap("n", "g*", "g*zz", XTND({ desc = "Next match" }))
keymap("n", "g#", "g#zz", XTND({ desc = "Previous match" }))

-- add context menu
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<cr>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<cr>]])
keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>", { silent = true })
keymap("n", "<Tab>", "<cmd>:popup mousemenu<cr>", { silent = true })

-- working with multi-line
keymap({ "n", "x" }, "j", "gj", XTND({ desc = "Move down" }))
keymap({ "n", "x" }, "k", "gk", XTND({ desc = "Move up" }))
keymap("n", "<leader>w", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<cr>", XTND({ desc = "Toggle word wrap" }))

-- toggle relative numbers (easier for pairing)
keymap("n", "<leader>rn", "<cmd>lua vim.wo.rnu = not vim.wo.rnu<cr>", XTND({ desc = "Toggle rnu" }))

-- Source config
keymap("n", "<leader><leader>c", "<cmd>source ~/.config/nvim/init.lua<cr>", { noremap = true, desc = "Reload Config" })

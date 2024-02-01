local keymap = vim.keymap.set

-- Better window navigation
keymap("n", "<m-h>", "<C-w>h", { noremap = true, silent = true, desc = "Move to window left" })
keymap("n", "<m-j>", "<C-w>j", { noremap = true, silent = true, desc = "Move to window down" })
keymap("n", "<m-k>", "<C-w>k", { noremap = true, silent = true, desc = "Move to window up" })
keymap("n", "<m-l>", "<C-w>l", { noremap = true, silent = true, desc = "Move to window right" })
keymap("n", "<m-tab>", "<c-6>")

-- Stay in indent mode
keymap("v", "<", "<gv", { noremap = true, silent = true, desc = "Indent left" })
keymap("v", ">", ">gv", { noremap = true, silent = true, desc = "Indent right" })

-- visually move lines
keymap("v", "<c-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move line down" })
keymap("v", "<c-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move line up" })

-- fixes pasting so it keeps the current register
keymap("x", "p", '"_dP', { noremap = true, silent = true, desc = "Paste without yanking" })

-- delete won't copy to register
keymap({ "n", "v" }, "<leader>d", '"_d', { noremap = true, silent = true, desc = "Delete without yanking" })

-- allows copying to system clipboard
keymap({ "n", "v" }, "<leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })

-- better defaults for Y and J
keymap("n", "Y", "yg$", { noremap = true, silent = true, desc = "Yank to end of line" })
keymap("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Join lines" })

-- better navigation, keep content in the center of the screen
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Scroll down" })
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Scroll up" })
keymap("n", "n", "nzz", { noremap = true, silent = true, desc = "Next match" })
keymap("n", "N", "Nzz", { noremap = true, silent = true, desc = "Previous match" })
keymap("n", "*", "*zz", { noremap = true, silent = true, desc = "Next match" })
keymap("n", "#", "#zz", { noremap = true, silent = true, desc = "Previous match" })
keymap("n", "g*", "g*zz", { noremap = true, silent = true, desc = "Next match" })
keymap("n", "g#", "g#zz", { noremap = true, silent = true, desc = "Previous match" })

-- add context menu
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<cr>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<cr>]])
keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>", { silent = true })
keymap("n", "<Tab>", "<cmd>:popup mousemenu<cr>", { silent = true })

-- working with multi-line
keymap({ "n", "x" }, "j", "gj", { noremap = true, silent = true, desc = "Move down" })
keymap({ "n", "x" }, "k", "gk", { noremap = true, silent = true, desc = "Move up" })
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

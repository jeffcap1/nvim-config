local keymap = vim.keymap.set

-- Better window navigation
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
-- keymap({ "n", "v" }, "<leader>d", '"_d', XTND({ desc = "Delete without yanking" }))

-- allows copying to system clipboard
-- keymap({ "n", "v" }, "<leader>y", '"+y', XTND({ desc = "Yank to clipboard" }))

-- buffer navigation
keymap("n", "]b", "<cmd>bnext<cr>", XTND({ desc = "Next Buffer" }))
keymap("n", "[b", "<cmd>bprev<cr>", XTND({ desc = "Previous Buffer" }))

-- tab navigation
keymap("n", "]<tab>", "<cmd>tabnext<cr>", XTND({ desc = "Next Tab" }))
keymap("n", "[<tab>", "<cmd>tabprev<cr>", XTND({ desc = "Previous Tab" }))

-- better defaults for Y and J
keymap("n", "Y", "yg$", XTND({ desc = "Yank to end of line" }))
keymap("n", "J", "mzJ`z", XTND({ desc = "Join lines" }))

-- better navigation, keep content in the center of the screen

local function center_on_scroll(km)
  vim.wo.scrolloff = 999
  vim.defer_fn(function()
    vim.wo.scrolloff = 8
  end, 500)
  return km
end

-- keymap("n", "<C-d>", "<C-d>zz", XTND({ desc = "Scroll down" }))
-- keymap("n", "<C-u>", "<C-u>zz", XTND({ desc = "Scroll up" }))

-- stylua: ignore
local scroll_keymaps = {
  {"n", "Next Match" },
  {"N", "Previous Match" },
  {"*", "Next Match" },
  {"#", "Previous Match" },
  {"g*", "Next Match" },
  {"g#", "Previous Match" },
  {"<c-d>", "Half Page Down" },
  {"<c-u>", "Half Page Up" },
  {"<c-f>", "Full Page Down" },
  {"<c-b>", "Full Page Up" },
}

for key, km in pairs(scroll_keymaps) do
  keymap("n", km[1], function()
    return center_on_scroll(km[1])
  end, { expr = true, desc = km[2] })
end

--[[ keymap("n", "n", function()
  return center_on_scroll("n")
end, { expr = true, desc = "Next match" })
keymap("n", "N", function()
  return center_on_scroll("Nzz")
end, { expr = true, desc = "Previous match" })
keymap("n", "*", function()
  return center_on_scroll("*zz")
end, { expr = true, desc = "Next match" })
keymap("n", "#", function()
  return center_on_scroll("#zz")
end, { expr = true, desc = "Previous match" })
keymap("n", "g*", function()
  return center_on_scroll("g*zz")
end, { expr = true, desc = "Next match" })
keymap("n", "g#", function()
  return center_on_scroll("g#zz")
end, { expr = true, desc = "Previous match" })
keymap("n", "<C-d>", function()
  return center_on_scroll("<C-d>")
end, { expr = true })
keymap("n", "<C-k>", function()
  return center_on_scroll("<C-d>")
end, { expr = true })

keymap("n", "<C-u>", function()
  vim.wo.scrolloff = 999
  vim.defer_fn(function()
    vim.wo.scrolloff = 8
  end, 500)
  return "<c-u>"
end, { expr = true }) ]]
-- stylua: ignore end

-- add context menu
vim.cmd([[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<cr>]])
vim.cmd([[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<cr>]])
keymap("n", "<RightMouse>", "<cmd>:popup mousemenu<cr>", { silent = true })
-- keymap("n", "<Tab>", "<cmd>:popup mousemenu<cr>", { silent = true })

-- working with multi-line
keymap({ "n", "x" }, "j", "gj", XTND({ desc = "Move down" }))
keymap({ "n", "x" }, "k", "gk", XTND({ desc = "Move up" }))
-- keymap("n", "<leader>w", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<cr>", XTND({ desc = "Toggle word wrap" }))

-- toggle relative numbers (easier for pairing)
keymap("n", "<leader><leader>r", "<cmd>lua vim.wo.rnu = not vim.wo.rnu<cr>", XTND({ desc = "Toggle rnu" }))

-- Source config
keymap("n", "<leader><leader>c", "<cmd>luafile $MYVIMRC<CR>", { noremap = true, desc = "Reload Config" })

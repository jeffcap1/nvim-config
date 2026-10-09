local keymap = vim.keymap.set

-- Stay in indent mode
keymap("v", "<", "<gv", XTND({ desc = "Indent left" }))
keymap("v", ">", ">gv", XTND({ desc = "Indent right" }))

-- visually move lines
keymap("v", "<c-j>", ":m '>+1<cr>gv=gv", XTND({ desc = "Move line down" }))
keymap("v", "<c-k>", ":m '<-2<cr>gv=gv", XTND({ desc = "Move line up" }))

-- fixes pasting so it keeps the current register
keymap("x", "p", [["_c<C-r><C-o>"<Esc>]], XTND({ desc = "Paste without yanking" }))

-- buffer navigation
keymap("n", "]b", "<cmd>bnext<cr>", XTND({ desc = "Next Buffer" }))
keymap("n", "[b", "<cmd>bprev<cr>", XTND({ desc = "Previous Buffer" }))

-- terminal navigation (<M-hjkl> lives in vim-tmux-navigator.lua for n + t modes)
keymap("t", "<C-t>", [[<C-\><C-n>]], XTND({ desc = "Exit Terminal Mode" }))

-- drop built-in LSP gr* defaults (grr/gri/grn/gra/grt/grx) so `gr` (references)
-- fires instantly; each is already covered by gr/gI/<leader>l{r,a,D,l}
for _, map in ipairs({
  { "n", "grr" },
  { "n", "gri" },
  { "n", "grn" },
  { "n", "gra" },
  { "x", "gra" },
  { "n", "grt" },
  { "n", "grx" },
}) do
  pcall(vim.keymap.del, map[1], map[2])
end

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
    vim.wo.scrolloff = 2
  end, 500)
  return km
end

-- stylua: ignore
local scroll_center_keymaps = {
  {"n", "Next Match" },
  {"N", "Previous Match" },
  {"*", "Next Match" },
  {"#", "Previous Match" },
  {"g*", "Next Match" },
  {"g#", "Previous Match" },
  {"<c-d>", "Half Page Down" },
  {"<c-u>", "Half Page Up" },
}

for key, km in pairs(scroll_center_keymaps) do
  keymap("n", km[1], function()
    return center_on_scroll(km[1])
  end, { expr = true, desc = km[2] })
end

-- working with multi-line
keymap({ "n", "x" }, "j", "gj", XTND({ desc = "Move down" }))
keymap({ "n", "x" }, "k", "gk", XTND({ desc = "Move up" }))
-- keymap("n", "<leader>w", "<cmd>lua vim.wo.wrap = not vim.wo.wrap<cr>", XTND({ desc = "Toggle word wrap" }))

-- toggle relative numbers (easier for pairing)
keymap("n", "<leader><leader>r", "<cmd>lua vim.wo.rnu = not vim.wo.rnu<cr>", XTND({ desc = "Toggle rnu" }))

-- Restart nvim (0.12+): saves session, restarts with same argv, restores session.
-- lazy.nvim can't re-source the config in place, so this is the "reload config".
-- If the session double-restores with persisted.nvim, switch to `restart!`.
keymap("n", "<leader><leader>c", "<cmd>restart<cr>", XTND({ desc = "Restart Neovim" }))

local keymap = vim.keymap.set
local opts = function(desc)
  return { buffer = true, desc = desc }
end

keymap("n", "<leader>mp", "<cmd>MarkdownPreview<CR>", opts("Markdown preview"))
keymap("n", "<leader>ms", "<cmd>MarkdownPreviewStop<CR>", opts("Markdown preview stop"))
keymap("n", "<leader>mt", "<cmd>MarkdownPreviewToggle<CR>", opts("Markdown preview toggle"))

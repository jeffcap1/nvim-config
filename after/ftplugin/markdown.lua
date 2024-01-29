local keymap = vim.keymap.set

keymap("n", "<leader>mp", "<cmd>:MarkdownPreview<CR>")
keymap("n", "<leader>ms", "<cmd>:MarkdownPreviewStop<CR>")
keymap("n", "<leader>mt", "<cmd>:MarkdownPreviewToggle<CR>")

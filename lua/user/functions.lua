local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 200,
        })
    end,
})

local whitespace_group = vim.api.nvim_create_augroup('BufWhiteSpace', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = whitespace_group,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

local M = {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
}

M.init = function()
  local ensureInstalled = {
    "bash",
    "css",
    "git_config",
    "git_rebase",
    "html",
    "javascript",
    "json5",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "regex",
    "sql",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  }

  local alreadyInstalled = require("nvim-treesitter.config").get_installed()
  local parsersToInstall = vim
    .iter(ensureInstalled)
    :filter(function(parser)
      return not vim.tbl_contains(alreadyInstalled, parser)
    end)
    :totable()
  require("nvim-treesitter").install(parsersToInstall)
end

-- load language features based on filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft)

    -- auto install new languages not in treesitter yet
    if not vim.treesitter.language.add(lang) then
      local available = vim.g.ts_available or require("nvim-treesitter").get_available()
      if not vim.g.ts_available then
        vim.g.ts_available = available
      end
      if vim.tbl_contains(available, lang) then
        require("nvim-treesitter").install(lang)
      end
    end

    -- Enable treesitter highlighting and disable regex syntax
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end
  end,
})

-- keymaps for incremental selection
vim.keymap.set({ "x" }, "[n", function()
  require("vim.treesitter._select").select_prev(vim.v.count1)
end, { desc = "Select previous treesitter node" })

vim.keymap.set({ "x" }, "]n", function()
  require("vim.treesitter._select").select_next(vim.v.count1)
end, { desc = "Select next treesitter node" })

vim.keymap.set({ "x", "o" }, "an", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = "Select parent treesitter node or outer incremental lsp selections" })

vim.keymap.set({ "x", "o" }, "in", function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require("vim.treesitter._select").select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = "Select child treesitter node or inner incremental lsp selections" })

return M

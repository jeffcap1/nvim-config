return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "tsserver" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require('lspconfig')

      -- setup language server
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})

      -- lsp keybindings
      vim.keymap.set('n', 'gh', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
      vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, {})
    end
  }
}

local lsp_servers = {
  "bashls",
  "cssls",
  "graphql",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright",
  "sqlls",
  "tsserver",
  "yamlls",
}

local lua_formatting = {
  format = {
    enable = true,
    defaultConfig = {
      indent_style = "space",
      indent_size = "2",
    },
  },
}

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      -- setup language server
      local servers = lsp_servers
      for _, lsp in ipairs(servers) do
        local M = {}
        M.capabilities = capabilities

        if lsp == "lua_ls" then
          M.Lua = lua_formatting
        end

        if lsp == "jsonls" then
          M.settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          }
        end

        if lsp == "yamlls" then
          M.settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          }
        end

        lspconfig[lsp].setup(M)
      end

      -- lsp keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP hover help", buffer = ev.buf })
          vim.keymap.set(
            "n",
            "<leader>ls",
            vim.lsp.buf.signature_help,
            { desc = "LSP function signature", buffer = ev.buf }
          )
          vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP definition", buffer = ev.buf })
          vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "LSP declaration", buffer = ev.buf })
          vim.keymap.set(
            "n",
            "<leader>li",
            vim.lsp.buf.implementation,
            { desc = "LSP implementation", buffer = ev.buf }
          )
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP references", buffer = ev.buf })
          vim.keymap.set(
            { "n", "v" },
            "<leader>la",
            vim.lsp.buf.code_action,
            { desc = "LSP code actions", buffer = ev.buf }
          )
          vim.keymap.set(
            "n",
            "<leader>ltd",
            vim.lsp.buf.type_definition,
            { desc = "LSP type definition", buffer = ev.buf }
          )
          vim.keymap.set("n", "f2", vim.lsp.buf.rename, { desc = "LSP rename", buffer = ev.buf })

          -- See `:help vim.diagnostic.*` for documentation on any of the below functions
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
          vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Diagnostic line help" })
          vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Diagnostic list locations" })
        end,
      })
    end,
  },
}

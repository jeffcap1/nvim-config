local M = {
  "saghen/blink.cmp",
  version = "v0.*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "lazydev",
  },
  event = "InsertEnter",
  dependencies = {
    { "L3MON4D3/LuaSnip", version = "v2.*" },
    "rafamadriz/friendly-snippets",
  },
}

-- local icons = require("user.icons")

---@module 'blink.cmp'
---@type blink.cmp.Config
M.opts = {
  -- Disable cmdline
  cmdline = { enabled = false },
  appearance = {
    -- sets the fallback highlight groups to nvim-cmp's highlight groups
    -- useful for when your theme doesn't support blink.cmp
    -- will be removed in a future release, assuming themes add support
    use_nvim_cmp_as_default = false,
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  completion = {
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      window = {
        winblend = vim.o.pumblend,
        border = "rounded",
      },
    },
    menu = {
      winblend = vim.o.pumblend,
      border = "rounded",
    },
    ghost_text = {
      enabled = false,
    },
  },

  -- experimental signature help support
  signature = {
    enabled = true,
  },

  snippets = {
    expand = function(...)
      return require("luasnip").lsp_expand(...)
    end,
  },

  keymap = {
    preset = "enter",
    ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
  },

  sources = {
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        fallbacks = { "lsp" },
      },
    },
  },

  -- kind_icons = icons.kind,
}

return M

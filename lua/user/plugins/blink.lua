local M = {
  "saghen/blink.cmp",
  version = "v0.*",
  opts_extend = {
    "sources.completion.enabled_providers",
    "lazydev",
  },
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
}

-- local icons = require("user.icons")

M.opts = {
  highlight = {
    -- sets the fallback highlight groups to nvim-cmp's highlight groups
    -- useful for when your theme doesn't support blink.cmp
    -- will be removed in a future release, assuming themes add support
    use_nvim_cmp_as_default = false,
  },
  -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  -- adjusts spacing to ensure icons are aligned
  nerd_font_variant = "mono",
  windows = {
    autocomplete = {
      -- draw = "reversed",
      winblend = vim.o.pumblend,
      border = "rounded",
    },
    documentation = {
      auto_show = true,
      border = "rounded",
    },
    ghost_text = {
      enabled = false,
    },
  },

  accept = {
    expand_snippet = function(...)
      return require("luasnip").lsp_expand(...)
    end,
    -- experimental auto-brackets support
    auto_brackets = { enabled = true },
  },

  -- experimental signature help support
  trigger = {
    signature_help = { enabled = true },
  },

  keymap = {
    preset = "enter",
    ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
  },

  sources = {
    providers = {
      lsp = {
        -- dont show LuaLS require statements when lazydev has items
        fallback_for = { "lazydev" },
      },
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
      },
    },
  },

  -- kind_icons = icons.kind,
}

return M

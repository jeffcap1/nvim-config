local M = {
  "saghen/blink.cmp",
  version = "1.*", -- release tags ship the prebuilt fuzzy-matcher binary
  opts_extend = {
    "sources.default",
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
  -- Disable cmdline and oil buffers
  cmdline = { enabled = false },
  enabled = function()
    return vim.bo.filetype ~= "oil"
  end,
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

  -- luasnip preset wires expand + active + jump to LuaSnip
  -- (expand alone left <Tab>/<S-Tab> jumping on vim.snippet, which can't see LuaSnip snippets)
  snippets = {
    preset = "luasnip",
  },

  keymap = {
    preset = "enter",
    ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
  },

  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100, -- rank above lua_ls (lazydev only returns items in lua buffers)
        fallbacks = { "lsp" },
      },
    },
  },

  -- kind_icons = icons.kind,
}

return M

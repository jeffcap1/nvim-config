-- include different lua config files
require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")
require("user.lsp_servers") -- LSP servers

-- startup
spec("user.plugins.theme")
spec("user.plugins.alpha")

-- lsp
spec("user.plugins.cmp")
spec("user.plugins.mason")
spec("user.plugins.lsp-config")
spec("user.plugins.none-ls")
spec("user.plugins.schemastore")

-- core plugins
spec("user.plugins.treesitter")
spec("user.plugins.telescope")
spec("user.plugins.gitsigns")
spec("user.plugins.ufo")
spec("user.plugins.harpoon")
spec("user.plugins.lualine")
spec("user.plugins.neotree")
spec("user.plugins.toggleterm")
spec("user.plugins.project")

-- quality of life
spec("user.plugins.comment")
spec("user.plugins.nvim-surround")
spec("user.plugins.indent-blankline")
spec("user.plugins.autopairs")
spec("user.plugins.autotag")
spec("user.plugins.markdown-preview")
spec("user.plugins.rainbow-delimiters")
spec("user.plugins.which-key")
spec("user.plugins.noice")

-- other useful plugins
spec("user.plugins.navic")
spec("user.plugins.breadcrumbs")
spec("user.plugins.extras.copilot")
spec("user.plugins.extras.oil")
-- spec("user.plugins.extras.illuminate")
spec("user.plugins.extras.eyeliner")
spec("user.plugins.extras.gitlinker")

require("user.lazy")

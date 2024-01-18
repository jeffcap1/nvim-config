-- include different lua config files
require("user.launch")
require("user.options")
require("user.keymaps")
require("user.functions")
require("user.lsp_servers") -- LSP servers

-- start plugins
spec("user.plugins.theme")
spec("user.plugins.alpha")
spec("user.plugins.treesitter")
spec("user.plugins.telescope")
-- lsp
spec("user.plugins.cmp")
spec("user.plugins.mason")
spec("user.plugins.lsp-config")
spec("user.plugins.none-ls")
spec("user.plugins.schemastore")
-- end lsp
spec("user.plugins.indent-blankline")
spec("user.plugins.lualine")
spec("user.plugins.neotree")
spec("user.plugins.toggleterm")
spec("user.plugins.ufo")
spec("user.plugins.comment")
spec("user.plugins.autopairs")
spec("user.plugins.autotag")
spec("user.plugins.nvim-surround")
spec("user.plugins.markdown-preview")
spec("user.plugins.rainbow-delimiters")
spec("user.plugins.noice")
spec("user.plugins.which-key")
spec("user.plugins.extras.copilot")
-- end plugins

require("user.lazy")

-- include different lua config files

require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocmds")

-- LSP servers
require("user.lsp_servers")
pcall(require, "user.local_lsp_servers")

-- DAP servers
require("user.dap_servers")
pcall(require, "user.local_dap_servers")

-- startup
spec("user.plugins.theme")
-- spec("user.plugins.alpha")

-- lsp
-- spec("user.plugins.cmp")
spec("user.plugins.blink")
spec("user.plugins.luasnip")
spec("user.plugins.mason")
spec("user.plugins.lsp-config")
spec("user.plugins.none-ls")
spec("user.plugins.conform")
spec("user.plugins.schemastore")
spec("user.plugins.venv-selector")
spec("user.plugins.mini-icons")

-- core plugins
spec("user.plugins.snacks")
spec("user.plugins.vim-tmux-navigator")
spec("user.plugins.treesitter")
spec("user.plugins.telescope")
spec("user.plugins.gitsigns")
spec("user.plugins.neogit")
spec("user.plugins.blame")
spec("user.plugins.ufo")
spec("user.plugins.harpoon")
spec("user.plugins.lualine")
spec("user.plugins.neotree")
spec("user.plugins.toggleterm")
spec("user.plugins.project")

-- quality of life
spec("user.plugins.bqf")
spec("user.plugins.comment")
spec("user.plugins.nvim-surround")
-- spec("user.plugins.hlchunk")
-- spec("user.plugins.indent-blankline")
spec("user.plugins.autopairs")
spec("user.plugins.autotag")
spec("user.plugins.markdown-preview")
spec("user.plugins.marks")
spec("user.plugins.rainbow-delimiters")
spec("user.plugins.which-key")
spec("user.plugins.noice")

-- other useful plugins
spec("user.plugins.breadcrumbs")
spec("user.plugins.extras.debugger")
-- spec("user.plugins.extras.dressing") -- snacks?
spec("user.plugins.extras.eyeliner")
spec("user.plugins.extras.gitlinker") -- snacks?
spec("user.plugins.extras.highlight-colors")
spec("user.plugins.extras.lab")
spec("user.plugins.extras.lazydev")
spec("user.plugins.extras.mini-ai")
spec("user.plugins.extras.modicator")
spec("user.plugins.extras.navbuddy")
spec("user.plugins.extras.oil")
spec("user.plugins.extras.pretty-ts-errors")
spec("user.plugins.extras.tabby")
spec("user.plugins.extras.todo-comment")
spec("user.plugins.extras.trouble")
spec("user.plugins.extras.wit-search")
spec("user.plugins.navic")

pcall(require, "user.plugins.local_only") -- local plugins

require("user.lazy")

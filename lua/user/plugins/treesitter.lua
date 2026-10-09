-- TODO: consider replacing nvim-treesitter with arborist-ts/arborist.nvim.
--   + bundles queries for 330 langs, incl. ones nvim-treesitter dropped (tmux)
--   + auto-install/highlight/indent built in; replaces the autocmd + list below
--   - WASM path unused here (nvim built without wasmtime); native builds only
--   - unverified that it can build tmux (upstream removed src/parser.c);
--     test with :ArboristInstall tmux
--   Don't run both. On switch: drop nvim-treesitter dep from render-markdown.lua
--   and codecompanion.lua, clean ~/.local/share/nvim/site/{parser,queries,parser-info}.
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
    if not lang then return end

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
    -- (folding is owned by nvim-ufo, see ufo.lua)
    -- Require a highlights query too: a parser without queries (e.g. languages
    -- dropped upstream, like tmux) would kill regex syntax and render plain text.
    -- NOTE: if a file suddenly renders black & white, check for a stale parser:
    --   :lua =vim.treesitter.query.get(vim.bo.filetype, "highlights")
    -- nil => parser installed but queries gone (lang dropped by nvim-treesitter).
    -- Fix: rm ~/.local/share/nvim/site/{parser/<lang>.so,queries/<lang>,parser-info/<lang>.revision}
    -- This guard only covers this autocmd; snacks quickfile still starts TS for
    -- the first CLI-opened file whenever a parser loads, so the rm is required.
    if vim.treesitter.language.add(lang) and vim.treesitter.query.get(lang, "highlights") then
      vim.treesitter.start(args.buf, lang)
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- incremental selection ([n ]n [N ]N an in) is built into nvim 0.12 defaults

return M

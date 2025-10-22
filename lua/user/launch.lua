LAZY_PLUGIN_SPEC = {}

-- load a plugin, acts like require
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

local project_root_cache = {}

local function get_project_root()
  local initial_cwd = vim.fn.getcwd()

  if project_root_cache[initial_cwd] then
    return project_root_cache[initial_cwd]
  end

  local root_markers_priority = {
    ".git", -- 1: Highest priority - Git repository root
    "pnpm-workspace.yaml", -- 2: Monorepo-specific markers
    "lerna.json",
    "nx.json",
    "package.json", -- N: Generic project marker (lowest for monorepo root)
  }

  local best_root_path = initial_cwd
  local best_marker_priority_idx = #root_markers_priority + 1
  local path_to_scan = initial_cwd

  while #path_to_scan > 1 and path_to_scan ~= "/" do
    for i, marker in ipairs(root_markers_priority) do
      local full_path_to_marker = path_to_scan .. "/" .. marker
      -- Using shell command becuase nvim.fn functions were returning a false positive
      local shell_check_output =
        vim.fn.system("test -e " .. vim.fn.shellescape(full_path_to_marker) .. " && echo 1 || echo 0")
      local marker_exists_string = shell_check_output:gsub("%s*$", "") -- Remove ONLY trailing whitespace (including newlines)

      if marker_exists_string == "1" then -- Compare the string directly
        if i < best_marker_priority_idx then
          best_marker_priority_idx = i
          best_root_path = path_to_scan
        end
        if i == 1 then
          goto skip_markers_at_this_level
        end
      end
    end
    ::skip_markers_at_this_level::

    local next_path = vim.fn.fnamemodify(path_to_scan, ":h")
    if next_path == path_to_scan then
      break
    end
    path_to_scan = next_path
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if clients and #clients > 0 then
    local best_lsp_root = nil
    for _, client in ipairs(clients) do
      if client.workspace_folders and #client.workspace_folders > 0 then
        local lsp_root_candidate = client.workspace_folders[1].uri:gsub("file://", "")
        if type(lsp_root_candidate) == "string" and #lsp_root_candidate > 0 then
          if not best_lsp_root or lsp_root_candidate:len() < best_lsp_root:len() then
            best_lsp_root = lsp_root_candidate
          end
        end
      end
    end

    if best_lsp_root then
      if best_lsp_root:len() <= best_root_path:len() and best_root_path:find(best_lsp_root, 1, true) == 1 then
        best_root_path = best_lsp_root
      end
    end
  end

  project_root_cache[initial_cwd] = best_root_path
  return best_root_path
end

function FILE_EXISTS_IN_PROJECT_ROOT(filename)
  local project_root = get_project_root()
  return vim.fn.filereadable(project_root .. "/" .. filename) == 1
end

function IS_JS_FILETYPE()
  local js_filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
    "css",
    "scss",
    "less",
    "html",
    "json",
    "jsonc",
    "yaml",
    "markdown",
    "graphql",
  }
  local ft = vim.bo.filetype
  for _, v in ipairs(js_filetypes) do
    if ft == v then
      return true
    end
  end
  return false
end

-- check if a variable is a table
local function is_table(t)
  return type(t) == "table"
end

-- print a tables' values
-- @see https://stackoverflow.com/a/27028488
function _DUMP(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. _DUMP(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

-- extends defualt options, typically for keymaps
function XTND(...)
  local options = { noremap = true, silent = true }
  local opts = { ... }

  if opts then
    local _opts = {}
    for k, v in pairs(opts) do
      local opt = {}
      if is_table(v) then
        opt = v
      else
        opt[k] = v
      end
      _opts = vim.tbl_extend("force", _opts, opt)
    end
    options = vim.tbl_extend("force", options, _opts)
  end

  return options
end

-- stylua: ignore
NOTIFY = {
  INFO = function(msg) vim.notify(msg, vim.log.levels.INFO) end,
  WARNING = function(msg) vim.notify(msg, vim.log.levels.WARN) end,
  ERROR = function(msg) vim.notify(msg, vim.log.levels.ERROR) end,
}

--- Gets a path to a package in the Mason registry.
--- Prefer this to `get_package`, since the package might not always be
--- available yet and trigger errors.
---@param pkg string
---@param path? string
---@param opts? { warn?: boolean }
-- stylua: ignore
function GET_PKG_PATH(pkg, path, opts)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  if opts.warn and not vim.loop.fs_stat(ret) then
    NOTIFY.WARNING(string.format("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package.", pkg, path))
  end
  return ret
end

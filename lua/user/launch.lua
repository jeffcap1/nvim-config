LAZY_PLUGIN_SPEC = {}

-- load a plugin, acts like require
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
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

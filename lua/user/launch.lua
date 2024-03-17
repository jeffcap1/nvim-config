LAZY_PLUGIN_SPEC = {}

-- load a plugin, acts like require
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- check if a variable is a table
local function is_table(t) return type(t) == "table" end

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
      if is_table(v) then opt = v else opt[k] = v end
      _opts = vim.tbl_extend("force", _opts, opt)
    end
    options = vim.tbl_extend("force", options, _opts)
  end

  return options
end

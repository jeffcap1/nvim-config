LAZY_PLUGIN_SPEC = {}

-- load a plugin, acts like require
function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

-- extends defualt options, typically for keymaps
function XTND(...)
  local options = { noremap = true, silent = true }
  local opts = table.unpack({ ... })
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  return options
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

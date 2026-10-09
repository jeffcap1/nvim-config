-- Find a Node.js binary from the version managers installed on this machine.
--
-- Resolvers run in order; the first one that returns a node meeting the version
-- requirement wins. To support another tool (vite-plus, bun, mise, nvm, ...), add a
-- { name, find } entry where it should rank. `find(min)` returns a path or nil;
-- helpers below handle "newest installed version >= min" for version-dir layouts.
local M = {}

---@param s string "v24.9.0" | "24.9.0"
---@return integer[]? { major, minor, patch }
local function parse(s)
  local a, b, c = tostring(s):match("v?(%d+)%.(%d+)%.(%d+)")
  return a and { tonumber(a), tonumber(b), tonumber(c) } or nil
end

local function newer(a, b)
  for i = 1, 3 do
    if a[i] ~= b[i] then
      return a[i] > b[i]
    end
  end
  return false
end

local function executable(path)
  return path and vim.fn.executable(path) == 1 and path or nil
end

--- Newest version dir in `dir` whose major >= min, as a node path built by `to_bin(dir, name)`.
---@param dir string directory containing one subdir per version
---@param min integer
---@param to_bin fun(dir: string, name: string): string
---@return string?
local function newest_in(dir, min, to_bin)
  local best, best_v
  for name, type in vim.fs.dir(dir) do
    local v = (type == "directory" or type == "link") and parse(name)
    if v and v[1] >= min and (not best_v or newer(v, best_v)) then
      local bin = executable(to_bin(dir, name))
      if bin then
        best, best_v = bin, v
      end
    end
  end
  return best
end

---@type { name: string, find: fun(min: integer): string? }[]
M.resolvers = {
  {
    name = "fnm",
    find = function(min)
      local root = vim.env.FNM_DIR or vim.fs.joinpath(vim.env.HOME, ".local/share/fnm")
      return newest_in(vim.fs.joinpath(root, "node-versions"), min, function(dir, name)
        return vim.fs.joinpath(dir, name, "installation/bin/node")
      end)
    end,
  },
  {
    name = "volta",
    find = function(min)
      local root = vim.env.VOLTA_HOME or vim.fs.joinpath(vim.env.HOME, ".volta")
      local images = vim.fs.joinpath(root, "tools/image/node")
      local to_bin = function(dir, name)
        return vim.fs.joinpath(dir, name, "bin/node")
      end
      -- prefer volta's default runtime (`volta install node@x`) when it qualifies
      local ok, platform = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(vim.fs.joinpath(root, "tools/user/platform.json")), "\n"))
      end)
      local default = ok and platform and platform.node and platform.node.runtime
      local v = default and parse(default)
      if v and v[1] >= min then
        local bin = executable(to_bin(images, default))
        if bin then
          return bin
        end
      end
      return newest_in(images, min, to_bin)
    end,
  },
  {
    name = "path",
    find = function(min)
      local bin = vim.fn.exepath("node")
      if bin == "" then
        return nil
      end
      local out = vim.system({ bin, "--version" }, { text = true }):wait()
      local v = out.code == 0 and parse(out.stdout or "")
      return v and v[1] >= min and bin or nil
    end,
  },
}

local cache = {}

--- First node binary (by resolver order) with major version >= min_major.
---@param opts? { min_major?: integer }
---@return string? path, string? resolver name
function M.find(opts)
  local min = (opts and opts.min_major) or 0
  if cache[min] then
    return cache[min].path, cache[min].name
  end
  for _, resolver in ipairs(M.resolvers) do
    local ok, path = pcall(resolver.find, min)
    if ok and path then
      cache[min] = { path = path, name = resolver.name }
      return path, resolver.name
    end
  end
  return nil
end

return M

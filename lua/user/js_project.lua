-- Per-buffer JS tooling detection.
--
-- Answers "which linter/formatter does the project owning THIS buffer use?" by
-- searching upward from the buffer's file for each tool's config files. Used by
-- lsp-config (linter precedence) and conform (formatter choice) so they agree,
-- and so switching projects / monorepo packages mid-session picks the right tool.
local M = {}

M.config_files = {
  biome = { "biome.json", "biome.jsonc" },
  oxlint = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" },
  oxfmt = { ".oxfmtrc.json", ".oxfmtrc.jsonc" },
  eslint_flat = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  },
  eslint_legacy = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.mjs",
    ".eslintrc.cjs",
    ".eslintrc.ts",
    ".eslintrc.json",
    ".eslintrc.jsonc",
    ".eslintrc.yaml",
    ".eslintrc.yml",
  },
}

--- Linter precedence: the first tool whose config is found wins; lower tools stay off.
M.linter_precedence = { "biome", "oxlint", "eslint" }

---@param source integer|string bufnr or path
---@return string? path
local function path_of(source)
  if type(source) == "number" then
    local name = vim.api.nvim_buf_get_name(source)
    return name ~= "" and name or nil
  end
  return source
end

--- Nearest config file for `tool` above `source` (bufnr or path), or nil.
---@param source integer|string
---@param tool string key of M.config_files, or "eslint" (flat or legacy)
---@return string?
function M.find(source, tool)
  local path = path_of(source)
  if not path then
    return nil
  end
  local files = tool == "eslint"
      and vim.list_extend(vim.list_extend({}, M.config_files.eslint_flat), M.config_files.eslint_legacy)
    or M.config_files[tool]
  return vim.fs.find(files, { path = vim.fs.dirname(path), upward = true, type = "file", limit = 1 })[1]
end

---@param source integer|string
---@param tool string
---@return boolean
function M.uses(source, tool)
  return M.find(source, tool) ~= nil
end

--- True when a higher-precedence linter than `tool` is configured for `source`.
---@param source integer|string
---@param tool string one of M.linter_precedence
---@return string? winner name of the higher-precedence linter, if any
function M.shadowed_by(source, tool)
  for _, other in ipairs(M.linter_precedence) do
    if other == tool then
      return nil
    end
    if M.uses(source, other) then
      return other
    end
  end
  return nil
end

--- ESLint project with legacy (.eslintrc*) config and no flat config.
---@param source integer|string
---@return boolean
function M.eslint_is_legacy(source)
  local flat = M.find(source, "eslint_flat")
  local legacy = M.find(source, "eslint_legacy")
  if not legacy then
    return false
  end
  -- nearest config wins when both exist at different levels
  return not flat or #vim.fs.dirname(legacy) > #vim.fs.dirname(flat)
end

return M

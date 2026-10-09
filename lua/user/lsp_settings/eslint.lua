-- Legacy (.eslintrc*) projects need flat config forced off (eslint 8.21+ / 9.x default to flat).
-- Flat config (eslint.config.*) projects use the server default.
local legacy_config_files = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.mjs",
  ".eslintrc.cjs",
  ".eslintrc.ts",
  ".eslintrc.json",
  ".eslintrc.jsonc",
  ".eslintrc.yaml",
  ".eslintrc.yml",
}

local function is_legacy_project()
  for _, file in ipairs(legacy_config_files) do
    if FILE_EXISTS_IN_PROJECT_ROOT(file) then
      return true
    end
  end
  return false
end

local settings = {
  settings = {
    workingDirectory = { mode = "auto" },
  },
}

if is_legacy_project() then
  settings.settings.experimental = { useFlatConfig = false }
  settings.cmd_env = { ESLINT_USE_FLAT_CONFIG = "false" }
end

return settings

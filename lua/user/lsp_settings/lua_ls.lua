-- https://luals.github.io/wiki/settings/
-- https://github.com/LuaLS/vscode-lua/blob/master/setting/schema.json
return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "spec" },
      },
      runtime = {
        version = "LuaJIT",
        special = {
          spec = "require",
        },
      },
      workspace = {
        checkThirdParty = false,
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      hint = {
        enable = true,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        await = true,
        paramName = "All", -- "All" | "Literal" | "Disable"
        paramType = true,
        semicolon = "All", -- "All" | "SameLine" | "Disable"
        setType = false,
      },
      codeLens = {
        enable = true,
      },
      semantic = {
        keyword = true,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

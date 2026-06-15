return {
  settings = {
    workingDirectory = { mode = "auto" },
    experimental = {
      useFlatConfig = false,
    },
  },
  cmd_env = {
    ESLINT_USE_FLAT_CONFIG = "false",
  },
}

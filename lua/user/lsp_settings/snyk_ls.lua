local util = require("lspconfig.util")

return {
  cmd = { "snyk-ls" },
  root_dir = util.root_pattern(".git", ".snyk"),
  filetypes = {
    "go",
    "gomod",
    "javascript",
    "typescript",
    "json",
    "python",
    "requirements",
    "helm",
    "yaml",
    "terraform",
    "terraform-vars",
  },
  single_file_support = true,
  settings = {},
  -- Configuration from https://github.com/snyk/snyk-ls#configuration-1
  init_options = {
    activateSnykCode = "true",
    endpoint = vim.fn.getenv("SNYK_API_URL"),
    snykCodeApi = vim.fn.getenv("SNYK_DEEPROXY_API_URL"),
    organization = vim.fn.getenv("SNYK_ORG"),
    token = vim.fn.getenv("SNYK_TOKEN"),
  },
}

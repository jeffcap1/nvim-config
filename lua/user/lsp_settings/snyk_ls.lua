return {
  cmd = { "snyk-ls" },
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
  init_options = {
    token = vim.fn.getenv("SNYK_TOKEN"),
  },
}

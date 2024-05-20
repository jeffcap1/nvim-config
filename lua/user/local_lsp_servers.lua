local local_servers = {
  "intelephense",
  "theme_check", -- Shopify theme check
}

for _, server in ipairs(local_servers) do
  table.insert(USERS_LSP_SERVERS, server)
end

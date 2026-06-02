local M = {
  "FabijanZulj/blame.nvim",
  event = { "BufReadPost", "BufNewFile" },
}

-- stylua: ignore
M.keys = {
  { "<leader>gb", "<cmd>BlameToggle<cr>", desc = "Blame", silent = true, noremap = true },
}
-- stylua: ignore end

M.config = function()
  require("blame").setup()
end

local function open_pr_under_cursor()
  local line = vim.api.nvim_get_current_line()
  -- Match PR numbers like #1234 or PR #1234
  local pr = string.match(line, "#(%d+)")
  if pr then
    vim.fn.jobstart({ "gh", "pr", "view", pr, "-w" }, { detach = true })
  else
    vim.notify("No PR number found on this line", vim.log.levels.WARN)
  end
end

local function set_blame_pr_keymap(buf)
  vim.keymap.set("n", "<leader>gp", open_pr_under_cursor, { buffer = buf, desc = "Open PR in browser" })
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter" }, {
  callback = function(args)
    local buf = args.buf
    if vim.api.nvim_buf_get_name(buf) == "" and vim.bo[buf].filetype == "" and vim.bo[buf].modifiable then
      set_blame_pr_keymap(buf)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "blame", "git" },
  callback = function(args)
    set_blame_pr_keymap(args.buf)
  end,
})

return M

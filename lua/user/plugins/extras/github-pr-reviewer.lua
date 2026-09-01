local M = {
  "otavioschwanck/github-pr-reviewer.nvim",
  lazy = false,
}

M.opts = {}

M.config = function(_, opts)
  require("github-pr-reviewer").setup(opts)

  -- Plugin uses vim.fn.getcwd() to build file paths, but git diff --name-only
  -- returns paths relative to repo root. If cwd is a subdirectory (e.g. apps/web),
  -- paths like "apps/web/src/..." become "apps/web/apps/web/src/..." -> empty buffer.
  -- Fix: cd to git root whenever we're on a review branch.
  vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    group = vim.api.nvim_create_augroup("pr_reviewer_cwd_fix", { clear = true }),
    callback = function()
      local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1] or ""
      if branch:match("^reviewing_") then
        local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if root and root ~= "" and not root:match("^fatal") then
          vim.fn.chdir(root)
        end
      end
    end,
  })

  vim.api.nvim_create_user_command("PRReviewNumber", function(opts)
    local wanted = tonumber(opts.args)

    if not wanted then
      vim.notify("Expected a PR number", vim.log.levels.ERROR)
      return
    end

    local ui = require("github-pr-reviewer.ui")
    local original_select_pr = ui.select_pr
    local select_matching_pr

    select_matching_pr = function(prs, _, on_choice)
      ui.select_pr = original_select_pr

      if type(on_choice) ~= "function" then
        vim.notify("github-pr-reviewer: PR selector callback was not provided", vim.log.levels.ERROR)
        return
      end

      for _, pr in ipairs(prs) do
        if tonumber(pr.number) == wanted then
          on_choice(pr)
          return
        end
      end

      vim.notify(("PR #%d was not found among the repository's open PRs"):format(wanted), vim.log.levels.ERROR)
    end

    ui.select_pr = select_matching_pr
    vim.cmd("PRReview")

    vim.defer_fn(function()
      if ui.select_pr == select_matching_pr then
        ui.select_pr = original_select_pr
      end
    end, 30000)
  end, {
    nargs = 1,
    desc = "Review a specific GitHub PR",
  })
end

M.keys = {
  { "<leader>p", "<cmd>PRReviewMenu<cr>", desc = "PR Review Menu" },
  { "<leader>p", ":<C-u>'<,'>PRSuggestChange<CR>", desc = "Suggest change", mode = "v" },
}

return M

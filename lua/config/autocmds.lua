-- Don't format-on-save for markdown files.
-- Personal preference.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.b.autoformat = false
  end,
})

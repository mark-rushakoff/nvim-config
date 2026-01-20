-- Don't format-on-save for markdown files.
-- Personal preference.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "makefile",
  callback = function()
    vim.b.autoformat = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    vim.b.autoformat = false
  end,
})

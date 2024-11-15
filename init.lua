-- Confiugre everything for lazy vim first.
require("config.lazy")

-- kj to leave insert mode.
vim.keymap.set('i', 'kj', '<Esc>')

-- Control keys to move panes like normal hjkl.
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Line numbers in the left gutter.
vim.opt.number = true

-- Don't wrap long lines on the screen.
vim.opt.wrap = false

-- New splits go below or to the right (personal preference).
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Don't get into EOL battles at the end of files.
vim.opt.fixendofline = false

-- Match default bash behavior of tab-completion.
vim.opt.wildmode = "longest,list"

-- Adjust H, L, zt, zb to not go to the VERY top/bottom of the screen.
vim.opt.scrolloff = 3

-- Save everything on focus lost.
-- Ignore unnamed buffer warnings, etc.
vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    command = "silent! wa"
})

-- My preferences for UI configuration of neovide (a Neovim GUI).
if vim.g.neovide then
  -- Stop visually distracting animation during insert.
  vim.g.neovide_cursor_animate_in_insert_mode = false

  -- Basic, ligature-free font.
  vim.o.guifont = "Menlo"

  -- Disable another visually annoying jump.
  vim.g.neovide_cursor_animate_command_line = true

  -- Quick animations for less visual disturbance.
  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_scroll_animation_length = 0.05

  -- Ensure mouse doesn't block edited text.
  vim.g.neovide_hide_mouse_when_typing = true
end

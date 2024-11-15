return {
  'ziglang/zig.vim',
  init = function()
    -- disable format-on-save from `ziglang/zig.vim`
    vim.g.zig_fmt_autosave = 0
    -- don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0
  end,
}

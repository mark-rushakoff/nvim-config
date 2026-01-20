return {
  "neovim/nvim-lspconfig",
  config = function()
    -- LSP servers you want to set up
    local lspconfig = require('lspconfig')

    local common_on_attach = function(client, bufnr)
      -- LSP mappings
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = '[G]o to [D]efinition' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr , desc = '[G]o to [I]mplementation' })

      -- Leader so we don't bind over gt to navigate to the next tab.
      vim.keymap.set('n', '<localleader>gt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = '[G]o to [T]ype definition' })

      vim.keymap.set('n', '<localleader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = '[R]efactor: re[N]ame' })
    end

    -- Set up each LSP server
    vim.lsp.config('gopls', {
      cmd = { os.getenv('HOME') .. '/go/bin/gopls' },
      on_attach = function(client, bufnr)
        common_on_attach(client, bufnr)

        vim.keymap.set("n", "<localleader>t", function()
          local file = vim.fn.expand('%')
          local alternate = file:match("_test%.go$") and file:gsub("_test%.go$", ".go") or file:gsub("%.go$", "_test.go")
          vim.cmd('edit ' .. alternate)
        end, { desc = 'Go to alternate test file' })

        vim.keymap.set("n", "<localleader>T", function()
          local file = vim.fn.expand('%')
          local alternate = file:match("_test%.go$") and file:gsub("_test%.go$", ".go") or file:gsub("%.go$", "_test.go")
          vim.cmd('vsplit ' .. alternate)
        end, { desc = 'Open alternate test file in vsplit' })

        vim.api.nvim_create_autocmd("BufWritePre", {
          callback = function(args)
            -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports-and-formatting
            local params = vim.lsp.util.make_range_params()
            params.context = {only = {"source.organizeImports"}}
            -- buf_request_sync defaults to a 1000ms timeout. Depending on your
            -- machine and codebase, you may want longer. Add an additional
            -- argument after params if you find that you have to write the file
            -- twice for changes to be saved.
            -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
            for cid, res in pairs(result or {}) do
              for _, r in pairs(res.result or {}) do
                if r.edit then
                  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                  vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
              end
            end
            vim.lsp.buf.format({async = false})
          end,
        })
      end,
    })
    vim.lsp.enable('gopls')

    -- ZLS (LSP for Zig), mostly taken from:
    -- https://zigtools.org/zls/editors/vim/nvim-lspconfig/
    vim.lsp.config('zls', {
      -- Path to local build of ZLS
      cmd = { os.getenv('HOME') .. '/zsrc/zls/zig-out/bin/zls' },
      settings = {
        zls = {
          -- My path to a local build of zig master.
          -- Probably wrong on other machines.
          zig_exe_path = os.getenv('HOME') .. '/src/zig/build/stage3/bin/zig'
        }
      },
      on_attach = function(client, bufnr)
        common_on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = {"*.zig", "*.zon"},
          callback = function(ev)
            vim.lsp.buf.format()
          end,
        })
      end,
    })
    vim.lsp.enable('zls')
  end
}

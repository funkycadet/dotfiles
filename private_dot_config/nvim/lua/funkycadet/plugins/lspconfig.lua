---- Set up lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
---- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['rust_analyzer'].setup {
--  capabilities = capabilities
--  --on_attach = function(client, bufnr)
--  --vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--}
--require('lspconfig').pyright.setup {
--  capabilities = capabilities,
--  settings = {
--    python = {
--      analysis = {
--        typeCheckingMode = "off",
--        autoImportCompletions = true,
--        useLibraryCodeForTypes = true,
--        diagnosticMode = "workspace",
--        --diagnosticMode = "openFilesOnly",
--        --autoSearchPaths = true,
--        --useLibraryCodeForTypes = true,
--      },
--    },
--  },
--}

---- Setup Cairo to work with neovim
--require('lspconfig')['cairo_ls'].setup {
--  --cmd = { string.format("%s/.asdf/shims/scarb-cairo-language-server", os.getenv("HOME")), "/C", "--node-ipc" },
--  cmd = { "scarb-cairo-language-server", "/C", "--node-ipc" },
--  --cmd = { "/home/ericalaribe/.asdf/shims/scarb-cairo-language-server", "/C", "--node-ipc" },
--  --cmd = { "/home/ericalaribe/.asdf/shims/scarb" }
--  --filetypes = { "cairo" },
--  --root_dir = function(fname)
--  --return require('lspconfig').util.root_pattern("Scarb.toml", "cairo_project.toml", ".git")(fname) or vim.fn.getcwd()
--  --end,
--  --root_dir = { root },
--  init_options = {
--    hostInfo = "neovim"
--  },
--  capabilities = capabilities

--}

--require('lspconfig')['ts_ls'].setup {
--  capabilities = capabilities
--}

--require('lspconfig').clangd.setup {
--  capabilities = capabilities,
--  cmd = { "clangd", "--background-index", "--completion-style=bundled", "--header-insertion=iwyu" },
--  filetypes = { "c", "cpp", "objc", "objcpp" },
--  root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git") or vim.loop.cwd,
--  on_attach = function(client, bufnr)
--    -- Optional: Enable inlay hints if using Neovim 0.10+
--    if vim.lsp.inlay_hint then
--      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--    end
--  end,
--}


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Common on_attach function with buffer validation
local function on_attach(client, bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  -- Optional: Enable inlay hints if using Neovim 0.10+ (disabled for now to avoid errors)
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end
end

-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['rust_analyzer'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require('lspconfig').pyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { '*' },
        -- typeCheckingMode = "off",
        -- autoImportCompletions = true,
        -- useLibraryCodeForTypes = true,
        -- diagnosticMode = "workspace",
      },
    },
  },
}

-- Setup Cairo to work with neovim
require('lspconfig')['cairo_ls'].setup {
  cmd = { "scarb-cairo-language-server", "/C", "--node-ipc" },
  init_options = {
    hostInfo = "neovim"
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

require('lspconfig')['ts_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require('lspconfig').clangd.setup {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--completion-style=bundled", "--header-insertion=iwyu" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git") or vim.loop.cwd,
  on_attach = on_attach,
}

-- require('lspconfig').ruff.setup {
--   init_options = {
--     settings = {
--       -- Ruff language server settings go here
--     }
--   }
-- }

require('lspconfig').ruff.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  -- init_options = {
    settings = {
      ruff = {
      logLevel = 'info',
    }
  }
}
-- vim.lsp.enable('ruff')
-- require('lspconfig').ruff.setup({
--   init_options = {
--     settings = {
--       -- Ruff language server settings go here
--     }
--   }
-- })

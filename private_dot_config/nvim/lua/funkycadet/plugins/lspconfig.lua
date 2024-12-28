-- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
	--on_attach = function(client, bufnr)
        --vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  }
  require('lspconfig').pyright.setup {
		  capabilities = capabilities
  }

  -- Setup Cairo to work with neovim
  require('lspconfig')['cairo_ls'].setup {
		  --cmd = { string.format("%s/.asdf/shims/scarb-cairo-language-server", os.getenv("HOME")), "/C", "--node-ipc" },
		  cmd = { "scarb-cairo-language-server", "/C", "--node-ipc" },
		  --cmd = { "/home/ericalaribe/.asdf/shims/scarb-cairo-language-server", "/C", "--node-ipc" },
		  --cmd = { "/home/ericalaribe/.asdf/shims/scarb" }
 		  --filetypes = { "cairo" },
		  --root_dir = function(fname)
			--return require('lspconfig').util.root_pattern("Scarb.toml", "cairo_project.toml", ".git")(fname) or vim.fn.getcwd()
		  --end,
		  --root_dir = { root },
		  init_options = {
		    hostInfo = "neovim"
		  },
		  capabilities = capabilities

  }

  require('lspconfig')['ts_ls'].setup {
		capabilities = capabilities
  }

local cmp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

-- Set up lspconfig.
local capabilities = cmp.default_capabilities()
-- capabilities.general.positionEncodings = { "utf-16" }
capabilities.offsetEncoding = { "utf-16" }

-- Common on_attach function with buffer validation
local function on_attach(client, bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	-- Optional: Enable inlay hints if using Neovim 0.10+ (disabled for now to avoid errors)
	if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		-- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
	-- Optional: semantic tokens
	-- if client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens then
	--   vim.lsp.semantic_tokens.start(bufnr, client.id)
	-- end
end

-- Configure each LSP server
vim.lsp.config("rust_analyzer", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("pyright", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				ignore = { "*" },
				-- typeCheckingMode = "basic",
				-- autoImportCompletions = true,
				-- useLibraryCodeForTypes = true,
				-- diagnosticMode = "workspace",
			},
		},
	},
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client == nil then
--       return
--     end
--     if client.name == 'ruff' then
--       -- Disable hover in favor of Pyright
--       client.server_capabilities.hoverProvider = false
--     end
--   end,
--   desc = 'LSP: Disable hover capability from Ruff',
-- })

vim.lsp.config("cairo_ls", {
	-- cmd = { "scarb-cairo-language-server", "/C", "--node-ipc" },
	-- init_options = {
	--   hostInfo = "neovim"
	-- },
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("ts_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.config("clangd", {
	capabilities = capabilities,
	cmd = { "clangd", "--background-index", "--completion-style=bundled", "--header-insertion=iwyu" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_dir = require("lspconfig.util").root_pattern("compile_commands.json", ".git"),
	on_attach = on_attach,
})

-- vim.lsp.config("ruff", {
-- 	capabilities = capabilities,
-- 	on_attach = on_attach,
-- 	init_options = {
-- 		settings = {
-- 			logLevel = "info",
-- 			-- linting = {
-- 			--   enabled = true,
-- 			-- },
-- 			-- formatting = {
-- 			--   enabled = true,
-- 			-- },
-- 		},
-- 	},
-- })

-- newww
vim.lsp.config("ruff", {
	capabilities = capabilities,
	autostart = true,
	filetypes = { "python" },
	on_attach = function(client, bufnr)
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		-- 💡 Disable hover immediately when Ruff attaches
		client.server_capabilities.hoverProvider = false

		-- You can still call your shared on_attach
		on_attach(client, bufnr)
	end,
	configuration = "~/.config/ruff/ruff.toml",
	init_options = {
		-- configuration = "~/.config/ruff/ruff.toml",
		settings = {
			logLevel = "info",
			configurationPreference = "filesystemFirst",
		},
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil then
			return
		end
		if client.name == "ruff" then
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end
	end,
	desc = "LSP: Disable hover capability from Ruff",
})

-- Enable the LSP servers
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("pyright")
vim.lsp.enable("cairo_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("ruff")

-- md
vim.lsp.enable("marksman")

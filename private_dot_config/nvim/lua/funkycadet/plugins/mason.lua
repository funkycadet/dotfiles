-- mason.lua
local ok, mason = pcall(require, "mason")
if not ok then
	return
end

mason.setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- LSP bridge
local ok_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if ok_lsp then
	mason_lsp.setup({
		ensure_installed = {
			"gopls",
			"ts_ls", -- TypeScript / JS
			"lua_ls", -- Lua / Neovim
			-- no need for rust_analyzer, pyright, or clangd
		},
		automatic_installation = true,
	})
end

-- DAP bridge
local ok_dap, mason_dap = pcall(require, "mason-nvim-dap")
if ok_dap then
	mason_dap.setup({
		ensure_installed = {
			"codelldb", -- Rust / C / C++
			"debugpy", -- Python
			"delve", -- Go
			"js", -- Node / TS
		},
		automatic_installation = true,
	})
end

-- Extra tools (formatters / linters)
local ok_tools, mason_tools = pcall(require, "mason-tool-installer")
if ok_tools then
	mason_tools.setup({
		ensure_installed = {
			"goimports",
			"prettier",
			"stylua",
			"eslint_d",
			"golangci-lint",
			"shellcheck",
		},
		auto_update = false,
		run_on_start = true,
	})
end

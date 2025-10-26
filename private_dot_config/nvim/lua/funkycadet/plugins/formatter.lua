require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- go = { "goimports", "gofmt" },
		go = { "gofmt" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		css = { "prettier" },
		-- html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		-- python = { "isort", "black" }, -- Enable Python formatters
		--
		-- test 1
		--
		-- python = {
		-- 	-- To fix auto-fixable lint errors.
		-- 	"ruff_fix",
		-- 	-- To run the Ruff formatter.
		-- 	"ruff_format",
		-- 	-- To organize the imports.
		-- 	"ruff_organize_imports",
		-- },
		--
		-- test 2
		--
		python = function(bufnr)
			if require("conform").get_formatter_info("ruff_format", bufnr).available then
				return { "ruff_format" }
			else
				return { "black", "isort" }
			end
		end,
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		lsp_format = "fallback",
		async = false,
		timeout_ms = 1000,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	notify_no_formatters = true,
})

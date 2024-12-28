require'nvim-treesitter.configs'.setup {
	ensure_installed = { "c", "rust", "query", "vim", "vimdoc", "markdown", "markdown_inline", "python", "typescript", "json", "yaml" },
	highlight = { enable = true, },
	indent = { enable = true },
}

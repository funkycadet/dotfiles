require'nvim-treesitter.configs'.setup {
	ensure_installed = { 
    "c", "cairo", "rust", "go", "query", "vim", "vimdoc", "markdown",
    "markdown_inline", "python", "typescript", "json", "yaml", "dockerfile"
  },
	highlight = { enable = true, },
	indent = { enable = true },
}


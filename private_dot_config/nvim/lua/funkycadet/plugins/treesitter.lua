require'nvim-treesitter.configs'.setup {
	ensure_installed = { 
    "cairo", "rust", "go", "python", "typescript", "json", "yaml", "dockerfile"
  },
	highlight = { enable = true, },
	indent = { enable = true },
}


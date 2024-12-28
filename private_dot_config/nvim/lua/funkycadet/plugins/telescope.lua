return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.8',
	'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'},
	dependencies = {
		'nvim-lua/plenary.nvim',
		'sharkdp/fd',
	},
	config = function ()
		local telescope = require('telescope')
		vim.keymap.set('n', '<Leader>f', telescope, {})
		vim.keymap.set('n', '<Leader>ff', telescope.find_files, {})
		vim.keymap.set('n', '<Leader>s', telescope.session-lens, {})
	end
}

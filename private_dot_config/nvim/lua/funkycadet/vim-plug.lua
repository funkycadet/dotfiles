local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Bufferline
Plug('nvim-tree/nvim-web-devicons')
Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })


-- Statusline
Plug('nvim-lualine/lualine.nvim')
Plug('vim-airline/vim-airline')


-- Session management
Plug('rmagatti/auto-session')


-- LSP Plugins
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')
Plug('hrsh7th/vim-vsnip-integ')

-- wakatime tracker
Plug('wakatime/vim-wakatime')

-- crackboard.dev
Plug('boganworld/crackboard.nvim')

-- telescope and dependencies
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
Plug('sharkdp/fd')

-- Copilot
Plug('github/copilot.vim')

-- Git
Plug('tpope/vim-fugitive')

-- Prisma
Plug('prisma/vim-prisma')

-- yarn pkg manager
Plug('lbrayner/vim-rzip')

-- Debugger
Plug('mfussenegger/nvim-dap')
Plug('nvim-neotest/nvim-nio')
Plug('rcarriga/nvim-dap-ui')


-- comment
Plug('tpope/vim-commentary')

vim.call('plug#end')

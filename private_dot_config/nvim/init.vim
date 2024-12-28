set number
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
set tabstop=4               " number of columns occupied by a tabline
"set softtabspot=4			" Soft tab width in spaces
set shiftwidth=4  			" Amount of spaces when shifting
set autoindent		    	" enable automatic indentation
set mouse=a					" enable mouse support
set clipboard=unnamedplus	" enable clipboard
filetype plugin indent on
syntax on

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#fugitiveline#enabled = 1


" Bare minimum requirements from the docs
" set runtimepath^=~/.vim runtimepath +=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" Source plugin files
"source $HOME/.config/nvim/themes/airline.vim


call plug#begin()
" Plugins

" Bufferline
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
"

" Statusline
Plug 'nvim-lualine/lualine.nvim'
" Plug 'vim-airline/vim-airline'

" Session management
Plug 'rmagatti/auto-session'


" LSP Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" wakatime tracker
Plug 'wakatime/vim-wakatime'

" crackboard.dev
Plug 'boganworld/crackboard.nvim'

" telescope and dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sharkdp/fd'

" Copilot
Plug 'github/copilot.vim'

" Git
Plug 'tpope/vim-fugitive'

" Prisma
Plug 'prisma/vim-prisma'

" yarn pkg manager
Plug 'lbrayner/vim-rzip'

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'


"comment
Plug 'tpope/vim-commentary'

call plug#end()


" termguicolors setup for bufferline
set termguicolors


" key mappings 

" Telescope
" open telescope
nnoremap <leader>ff :Telescope<CR>
" find_files
nnoremap <leader>f :Telescope find_files<CR>
" session management
nnoremap <leader>s :Telescope session-lens<CR>
" fuzzy finder
nnoremap <leader>g :Telescope live_grep<CR>
nnoremap <leader>fz :Telescope current_buffer_fuzzy_find<CR>
"close files
nnoremap <leader>e :bd<CR>

" Git
nnoremap <leader>gd :Gvdiffsplit<CR>

" terminal
nnoremap <leader>t :terminal<CR>
" nnoremap <leader>tc <C-d><CR>


lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      --['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

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

  require'nvim-treesitter.configs'.setup {
		ensure_installed = { "c", "rust", "query", "vim", "vimdoc", "markdown", "markdown_inline", "python", "typescript", "json", "yaml" },
		highlight = { enable = true, },
		indent = { enable = true },
  }
  -- Setup crackboard
  require('crackboard').setup({
		session_key = '7d4a9f86ad637221a9754029d4b84f66ca4599a57489ac842677f354082653d3',
  })

  --- Bufferline 
  require("bufferline").setup{
--  	options = {
--		mode = "tabs",
--	}
  }

  --- Statusline 
  require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'nightfly',
	component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

  --- Session management configuration
  require("auto-session").setup {
      suppressed_dirs = { "~/", "~/Pictures", "~/Downloads", "/"},
    }

  --- DevIcons Setup
  require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- set the light or dark variant manually, instead of relying on `background`
 -- (default to nil)
 variant = "light|dark";
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
EOF


set number
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
set tabstop=4               " number of columns occupied by a tab 
set autoindent		    	" enable automatic indentation
set mouse=a					" enable mouse support
set clipboard=unnamedplus	" enable clipboard
filetype plugin indent on
syntax on

" settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Bare minimum requirements from the docs
" set runtimepath^=~/.vim runtimepath +=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

"autocmd BufNewFile,BufRead *.cairo set filetype=cairo

call plug#begin()
" Plugins
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'wakatime/vim-wakatime'
call plug#end()

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
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
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
		  --root_dir = { require('lspconfig').util.root_pattern("Scarb.toml", "cairo_project.toml", ".git") }
		  --root_dir = function(fname)
			--return require('lspconfig').util.root_pattern("Scarb.toml", "cairo_project.toml", ".git")(fname) or vim.fn.getcwd()
		  --end,
		  --root_dir = { root },
		  --init_options = {
		    --hostInfo = "neovim"
		  --},
		  capabilities = capabilities

  }
EOF


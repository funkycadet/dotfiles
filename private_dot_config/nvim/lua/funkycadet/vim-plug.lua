local vim = vim
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- Bufferline
Plug("nvim-tree/nvim-web-devicons")
-- Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

-- Statusline
Plug("nvim-lualine/lualine.nvim")

-- Session management
Plug("rmagatti/auto-session")

-- LSP Plugins
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")
-- Plug('hrsh7th/cmp-vsnip')
-- Plug('hrsh7th/vim-vsnip')
-- Plug('hrsh7th/vim-vsnip-integ')
Plug("L3MON4D3/LuaSnip", { ["tag"] = "v2.*", ["do"] = "make install_jsregexp" })
Plug("rafamadriz/friendly-snippets") -- Optional: Pre-made snippets

-- wakatime tracker
Plug("wakatime/vim-wakatime")

-- crackboard.dev
-- Plug('boganworld/crackboard.nvim')

-- telescope and dependencies
Plug("nvim-lua/plenary.nvim")
-- Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.8' })
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-treesitter/nvim-treesitter", {
	["do"] = function()
		vim.cmd(":TSUpdate")
	end,
})
Plug("nvim-treesitter/nvim-treesitter-context")
-- Plug('sharkdp/fd')
Plug("nvim-telescope/telescope-fzf-native.nvim", {
	["do"] = function()
		vim.fn.system("make")
	end,
})

-- telescope extensions
Plug("nvim-telescope/telescope-file-browser.nvim")
Plug("nvim-telescope/telescope-dap.nvim")

-- Copilot
-- Plug('github/copilot.vim')
-- Plug('zbirenbaum/copilot.lua')

-- Git
Plug("tpope/vim-fugitive")
Plug("lewis6991/gitsigns.nvim")

-- Prisma
Plug("prisma/vim-prisma")

-- yarn pkg manager
-- Plug('lbrayner/vim-rzip')

-- Debugger
Plug("mfussenegger/nvim-dap")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")
Plug("theHamsta/nvim-dap-virtual-text")
-- Debug adapters
-- JS/TS
Plug("microsoft/vscode-js-debug", {
	-- ['tag'] = '1.77.0',
	["do"] = function()
		vim.fn.system("npm install --legacy-peer-deps && npx gulp vsDebugServerBundle")
	end,
})
-- Python
Plug("mfussenegger/nvim-dap-python")

-- comment
Plug("tpope/vim-commentary")

-- alpha
Plug("goolord/alpha-nvim")

-- which-key
Plug("folke/which-key.nvim")

-- themes
Plug("folke/tokyonight.nvim")
Plug("catppuccin/nvim", { ["as"] = "catppuccin" })

-- vim-tmux-navigator
Plug("christoomey/vim-tmux-navigator")

-- formatter
Plug("stevearc/conform.nvim")

-- Markdown previewer
Plug("MeanderingProgrammer/render-markdown.nvim")
Plug("echasnovski/mini.nvim")

-- Mason ecosystem
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim")
Plug("jayp0521/mason-nvim-dap.nvim")
Plug("WhoIsSethDaniel/mason-tool-installer.nvim")

vim.call("plug#end")

-- Automatically install missing plugins
local function ensure_plugins_installed()
	local missing_plugins = false
	for plugin_name, _ in pairs(vim.g.plugs) do
		if vim.fn.isdirectory(vim.g.plugs[plugin_name].dir) == 0 then
			missing_plugins = true
			break
		end
	end

	if missing_plugins then
		vim.cmd("PlugInstall --sync | q") -- Install missing plugins and close after installation
	end
end

ensure_plugins_installed()

-- Function to dynamically require all plugin configuration files
local function load_plugins()
	local plugin_config_path = vim.fn.stdpath("config") .. "/lua/funkycadet/plugins/"
	for _, file in ipairs(vim.fn.readdir(plugin_config_path)) do
		if file:match("%.lua$") then
			local plugin_name = file:gsub("%.lua$", "")
			local ok, err = pcall(require, "funkycadet.plugins." .. plugin_name)
			if not ok then
				vim.notify("Error loading plugin config: " .. plugin_name .. "\n" .. err, vim.log.levels.ERROR)
			end
		end
	end
end

-- Call the function to load plugin configurations
load_plugins()

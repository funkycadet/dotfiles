local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
-- dashboard.section.header.val = {
  -- "                                                     ",
  -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  -- "                                                     ",  
-- }
  
-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
  -- dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
  dashboard.button("SPC ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>", { desc = "Find File" }),
  dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>", { desc = "Find Word" }),
  dashboard.button("SPC sr", "󰁯  > Find Session To Restore", "<cmd>Telescope session-lens<CR>", { desc = "Session Management" }),
  dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
}

-- Add footer
dashboard.section.footer.val = "🚀 Happy coding!"
dashboard.section.footer.opts = { position = "center" }

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Highlight customization
vim.cmd([[
    highlight AlphaHeader guifg=#FFD700
    highlight AlphaButton guifg=#00FF00
]])

-- Disable folding on alpha buffer
vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

-- set leader key to space
-- vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>q", "<cmd>qa!<CR>", { desc = "Quit" }) -- quit

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- vim-tmux-navigator
keymap.set("n", "<leader>1", "<cmd>TmuxNavigateLeft<CR>", { desc = "Switch to left window split" }) -- switch to left window split
keymap.set("n", "<leader>2", "<cmd>TmuxNavigateRight<CR>", { desc = "Switch to right window split" }) -- switch to right window split


-- Telescope
keymap.set("n", "<leader>ft", "<cmd>Telescope<CR>", { desc = "Open Telescope" }) -- open Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" }) -- find files 
keymap.set("n", "<leader>sr", "<cmd>Telescope session-lens<CR>", { desc = "Session Management" }) -- session management
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" }) -- live grep
keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Current Fuzzy Finder" }) -- fuzzy finder
keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Browser" }) -- file browser

-- close files 
keymap.set("n", "<leader>e", "<cmd>bd<CR>", { desc = "Close files" }) -- close files 

-- Git 
keymap.set("n", "<leader>gh", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff" }) -- Git diff
keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame<CR>", { desc = "Git blame" }) -- Git blame

-- Terminal 
keymap.set("n", "<leader>tm", "<cmd>terminal<CR>", { desc = "Terminal" }) -- Terminal
keymap.set("t", "<leader>t", "<C-\\><C-n><cmd>bd<CR>", { desc = "Close terminal" }) -- Close terminal

-- LSP
keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition" }) -- go to definition
keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to declaration" }) -- go to declaration
keymap.set("n", "gi", "<cmd>Telescope lsp_implementation()<CR>", { desc = "Go to implementation" }) -- go to implementation
keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Go to references" }) -- go to references
keymap.set("n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show hover" }) -- show hover
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" }) -- Rename
keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" }) -- Code action
keymap.set("n", "<leader>sd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { desc = "Show line diagnostics" }) -- Show line diagnostics


-- Debugger
-- keymap.set("n", "<leader>rc", function() require('dap').continue() end, { desc = "Start/Continue Debugging" })
-- keymap.set("n", "<leader>rb", function() require('dap').toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>rc", "<cmd>DapContinue<CR>", { desc = "Start/Continue Debugging" })
keymap.set("n", "<leader>rb", "<cmd>DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>rg", function() require('dap').run_to_cursor() end, { desc = "Run to cursor" })
keymap.set("n", "<leader>r0", "<cmd>DapStepOut<CR>", { desc = "Step Out" })
keymap.set("n", "<leader>ro", "<cmd>DapStepOver<CR>", { desc = "Step Over" })
keymap.set("n", "<leader>r?", function() require('dap').eval(nil, { enter = true }) end, { desc = "Evaluate" })
 
-- create a new file 
-- vim.keymap.set('n', '<leader>nf', function()
--     local filename = vim.fn.input('New file: ')
--     if filename ~= '' then
--         local path = vim.fn.expand('%:p:h') .. '/' .. filename
--         vim.cmd('edit ' .. path)
--     end
-- end, { desc = 'Create a new file' })

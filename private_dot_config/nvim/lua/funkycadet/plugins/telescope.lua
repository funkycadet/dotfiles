local telescope = require('telescope')
telescope.setup {
  defaults = {
    file_ignore_patterns = { "node_modules", "^.git/", "dist" },
    hidden = true,
    follow = true,
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      additional_args = function()
        return { "--hidden", "--no-ignore"}
      end
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension('dap')
telescope.load_extension('file_browser')
-- Run the `configurations` picker from nvim-dap
-- telescope.extensions.dap.configurations()

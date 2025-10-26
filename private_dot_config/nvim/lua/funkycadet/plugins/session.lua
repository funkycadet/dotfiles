--- Session management configuration
-- require("auto-session").setup {
-- 	suppressed_dirs = { "~/", "~/Pictures", "~/Downloads", "/"},
-- }
-- Recommended session options for auto-session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- auto-session setup
require('auto-session').setup {
  log_level = 'error',
  suppressed_dirs = { '~/', '~/Pictures', '~/Downloads', '/' },
  -- Delay LSP attachment
  post_restore_cmds = {
    function()
      -- Detach all LSP clients before restoring
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.lsp.buf_detach_client(bufnr, 0)
        end
      end
      -- Re-attach LSP clients after a delay
      vim.defer_fn(function()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.lsp.buf_notify(bufnr, 'textDocument/didOpen', {
              textDocument = {
                uri = vim.uri_from_bufnr(bufnr),
                languageId = vim.bo[bufnr].filetype,
                version = vim.lsp.util.buf_versions[bufnr] or 0,
                text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
              },
            })
          end
        end
      end, 100)
    end,
  },
}

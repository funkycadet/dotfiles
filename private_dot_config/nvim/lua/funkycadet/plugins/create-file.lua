local telescope = require('telescope.builtin')

-- Create a new file in the selected directory
function CreateFileWithTelescope()
    telescope.find_files({
        prompt_title = "Select Directory",
        find_command = { 'fd', '--type', 'd' }, -- Shows only directories
        attach_mappings = function(prompt_bufnr, map)
            local actions = require('telescope.actions')
            local action_state = require('telescope.actions.state')

            -- Define action for confirming selection
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selected_dir = action_state.get_selected_entry().path
                local filename = vim.fn.input("New File Name: ")

                if filename ~= "" then
                    local filepath = selected_dir .. "/" .. filename
                    vim.cmd("edit " .. filepath)
                else
                    vim.notify("No file name provided!", vim.log.levels.WARN)
                end
            end)

            return true
        end
    })
end

-- Key mapping
-- vim.keymap.set('n', '<leader>nf', CreateFileWithTelescope, { desc = "Create a new file in a selected directory" })

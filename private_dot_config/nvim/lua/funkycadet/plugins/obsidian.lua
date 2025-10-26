-- Create daily note with template
vim.keymap.set("n", "<leader>dn", function()
	local date = os.date("%Y-%m-%d")
	vim.cmd("e daily_journal/" .. date .. ".md")
	-- Auto-insert template
	vim.api.nvim_buf_set_lines(0, 0, -1, false, {
		"---",
		"created: " .. os.date("%Y-%m-%d %H:%M"),
		"tags: ",
		-- "status: #baby",
		"---",
		"",
		"# [[Tags|Add tags]]",
		"",
		"**Your Idea Here**",
		"",
		"## References",
	})
end, { desc = "Daily Note" })

-- Create atomic note
vim.keymap.set("n", "<leader>an", ":e personal/6_full_notes/", { desc = "Atomic Note" })

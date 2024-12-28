return {
	'wakatime/vim-wakatime',
	'boganworld/crackboard.nvim'
	config = function ()
		local crackboard, wakatime = require("crackboard"), require("wakatime")
		crackboard.setup(
			session_key = '7d4a9f86ad637221a9754029d4b84f66ca4599a57489ac842677f354082653d3',
		)
		wakatime
	end,
}




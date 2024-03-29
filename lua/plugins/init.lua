return {

	{
		"kylechui/nvim-surround",
		enabled = false,
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {},
	},
	{
		"max397574/better-escape.nvim",
		event = "VeryLazy",
		config = function()
			require("better_escape").setup({ mapping = { "jk", "jj" } })
		end,
	},
}

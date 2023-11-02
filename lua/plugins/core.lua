local vscode = require("core.utils").vscode
return {

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"smoka7/hop.nvim",
		version = "*",
		opts = {},
	},
	-- {
	--   'nvim-treesitter/nvim-treesitter',
	--   cond = not vscode,
	--   build = ':TSUpdate',
	--   dependencies = {
	--     { 'nvim-treesitter/playground' },
	--     {
	--       'RRethy/nvim-treesitter-endwise',
	--       config = function()
	--         require('nvim-treesitter.configs').setup({ endwise = { enable = true } })
	--       end,
	--     },
	--     {
	--       'nvim-treesitter/nvim-treesitter-context',
	--       opts = { enable = false },
	--       keys = {
	--         {
	--           '<LEADER>ck',
	--           -- '<C-k>',
	--           function()
	--             return require('treesitter-context').go_to_context()
	--           end,
	--           mode = 'n',
	--         },
	--         { '<LEADER>cc', '<CMD>TSContextToggle<CR>', mode = 'n' },
	--       },
	--     },
	--     'nvim-treesitter/nvim-treesitter-textobjects',
	--     {
	--       'windwp/nvim-ts-autotag',
	--       event = 'InsertEnter',
	--       opts = {},
	--     },
	--   },
	--   config = function()
	--     require('plugins.configs.treesitter')
	--   end,
	-- },
}

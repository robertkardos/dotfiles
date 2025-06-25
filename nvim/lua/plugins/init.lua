return {
	{
		"oxfist/night-owl.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			require("night-owl").setup({
				-- These are the default settings
				bold = true,
				italics = false,
				underline = true,
				undercurl = true,
				transparent_background = false,
			})
		end,
		opts = {
			inverse = false,
		}
	},
	{ 'Everblush/nvim', name = 'everblush' },
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('tokyonight').setup {
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			}

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			-- vim.cmd.colorscheme 'tokyonight-night'
			-- vim.cmd [[colorscheme tokyonight-night]]
			-- vim.o.background = "dark" -- colorscheme is set to latte flavour
		end
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"karb94/neoscroll.nvim",
		opts = {
			mappings = { -- Keys to be mapped to their corresponding default scrolling animation
				'<C-u>', '<C-d>',
				'<C-b>', '<C-f>',
				'<C-y>', '<C-e>',
				'zt', 'zz', 'zb',
			},
			hide_cursor = false, -- Hide cursor while scrolling
			stop_eof = true,    -- Stop at <EOF> when scrolling downwards
			respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
			cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
			duration_multiplier = 1.0, -- Global duration multiplier
			easing = 'sine',    -- Default easing function
			pre_hook = nil,     -- Function to run before the scrolling animation starts
			post_hook = nil,    -- Function to run after the scrolling animation ends
			performance_mode = false, -- Disable "Performance Mode" on all buffers.
			ignored_events = {  -- Events ignored while scrolling
				'WinScrolled', 'CursorMoved'
			},
		},
	},
	{
		'EvWilson/spelunk.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',  -- For window drawing utilities
			'nvim-telescope/telescope.nvim', -- Optional: for fuzzy search capabilities
			'nvim-treesitter/nvim-treesitter', -- Optional: for showing grammar context
		},
		config = function()
			require('spelunk').setup({
				base_mappings = {
					-- Toggle the UI open/closed
					toggle = '<leader>bb',
					-- Add a bookmark to the current stack
					add = '<leader>ba',
					-- Move to the next bookmark in the stack
					next_bookmark = '<leader>bn',
					-- Move to the previous bookmark in the stack
					prev_bookmark = '<leader>bp',
					-- Fuzzy-find all bookmarks
					search_bookmarks = '<leader>bf',
					-- Fuzzy-find bookmarks in current stack
					search_current_bookmarks = '<leader>bc',
					-- Fuzzy find all stacks
					search_stacks = '<leader>bs',
				},
				window_mappings = {
					close = '<esc>',
				},
				enable_status_col_display = true,
				enable_persist = true
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" }
		}
	},
	{
	  "nvim-telescope/telescope.nvim",
	  dependencies = {
		{ 
			"nvim-telescope/telescope-live-grep-args.nvim" ,
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	  },
	  config = function()
		local telescope = require("telescope")

		-- first setup telescope
		telescope.setup({
			-- your config
			vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		})

		-- then load the extension
		telescope.load_extension("live_grep_args")
	  end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- fill any relevant options here
		},
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	}
}

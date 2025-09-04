vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc]])

-- print(runtimepath)
-- require("config.lazy")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation  or more details.
	-- colorscheme that will be used when installing plugins.
	--	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true, notify = false },
})




vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		vim.keymap.set('n', 'grd', ':lua vim.lsp.buf.definition()<cr>zz<cr>')

		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end
		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
		end


		-- Auto-format ("lint") on save.
		-- Usually not needed if server supports "textDocument/willSaveWaitUntil".
		-- if not client:supports_method('textDocument/willSaveWaitUntil')
		-- 	and client:supports_method('textDocument/formatting') then
		-- 	vim.api.nvim_create_autocmd('BufWritePre', {
		-- 		group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
		-- 		buffer = args.buf,
		-- 		callback = function()
		-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		-- 		end,
		-- 	})
		-- end
	end,
})

vim.lsp.enable('luals')
vim.lsp.enable("clangd")










vim.keymap.set('n', '<space>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<space>fg', ':Telescope git_files<cr>')
vim.keymap.set('n', '<space>fr', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<space>fb', ':Telescope buffers<cr>')

vim.keymap.set('n', '<tab>', ':Neotree toggle<cr>')
vim.keymap.set('n', '<space><tab>', ':Neotree toggle current reveal_force_cwd<cr>')

vim.keymap.set("n", "<leader>F", ":lua vim.lsp.buf.format()<CR>", { desc = "auto format" })
vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.open_float()<CR>", { desc = "show diagnostics" })



require('telescope').setup {
	pickers = {
		find_files = {
			hidden = true
		}
	},
	defaults = {
		file_ignore_patterns = {".git"},
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			n = {
				['<c-d>'] = require('telescope.actions').delete_buffer
			}, -- n
			i = {
				["<C-h>"] = "which_key",
				['<c-d>'] = require('telescope.actions').delete_buffer
			} -- i
		} -- mappings
	},  -- defaults
}       -- telescope setup



require('lualine').setup({
	--options = { theme = 'night-owl' }
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = ' ', right = ' ' },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				'WinEnter',
				'BufEnter',
				'BufWritePost',
				'SessionLoadPost',
				'FileChangedShellPost',
				'VimResized',
				'Filetype',
				'CursorMoved',
				'CursorMovedI',
				'ModeChanged',
			},
		}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'diff', 'diagnostics' },
		lualine_c = { { 'filename', path = 1 } },
		lualine_x = { 'encoding', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}

})


require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)
    end
}




vim.cmd.colorscheme "night-owl"
-- vim.cmd.colorscheme "everblush"

-- This part is from https://www.reddit.com/r/neovim/comments/1ayub43/disable_all_italics_in_nvim_lazyvim_distro/ and it makes sure that all italics are turned off because they don't appear outside of tmux and they cause fg-bg inversions while in tmux
local hl_groups = vim.api.nvim_get_hl(0, {})
for key, hl_group in pairs(hl_groups) do
	if hl_group.italic then
		vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, { italic = false }))
	end
end

vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})

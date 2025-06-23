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
	checker = { enabled = true },
})




vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
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
		if not client:supports_method('textDocument/willSaveWaitUntil')
			and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
				end,
			})
		end
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

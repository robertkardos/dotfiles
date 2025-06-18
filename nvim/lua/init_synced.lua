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
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
-- cmd = { 'clangd', '--background-index', "--clang-tidy", "--header-insertion=iwyu", "--completion-style=detailed", "--function-arg-placeholders", "--fallback-style=llvm" },
-- root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt' },
-- filetypes = { 'c', 'cpp' },
vim.lsp.config.clangd = {
	cmd = { 'clangd', '--background-index' },
	root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt' },
	filetypes = { 'c', 'cpp' },
}
vim.lsp.config["lua-language-server"] = {
	cmd = { "lua-language-server" },
	root_markers = { ".luarc.json" },
	filetypes = { 'lua' },
}
vim.lsp.enable({ 'clangd', "lua-language-server" })

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		-- if client:supports_method('textDocument/completion') then
		-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		-- end

		--		vim.keymap.set("n", "<leader>F", ":vim.lsp.buf.format()<CR>", { desc = "" })
	end,
})


vim.keymap.set('n', '<space>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<space>fg', ':Telescope git_files<cr>')
vim.keymap.set('n', '<space>fr', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<space>fb', ':Telescope buffers<cr>')

vim.keymap.set('n', '<tab>', ':Neotree toggle<cr>')
vim.keymap.set('n', '<space><tab>', ':Neotree toggle current reveal_force_cwd<cr>')

vim.keymap.set("n", "<leader>F", ":lua vim.lsp.buf.format()<CR>", { desc = "auto format" })

--[[vim.diagnostic.config({
	virtual_lines = {
		current_line = true,
	},
})]]

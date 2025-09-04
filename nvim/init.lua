vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
require("init_synced")

vim.opt["tabstop"] = 4
vim.opt["softtabstop"] = 4
vim.opt["shiftwidth"] = 4
vim.opt["expandtab"] = true

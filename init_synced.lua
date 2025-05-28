vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
]])

print(runtimepath)
-- require("config.lazy")

print("synced shaite loaded")



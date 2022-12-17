vim.api.nvim_command('set runtimepath^=~/.vim')
vim.api.nvim_command('set runtimepath+=~/.vim/after')

vim.api.nvim_command('let &packpath = &runtimepath')

vim.api.nvim_command('source ~/.vim/vimrc')

require('sergio.mappings')

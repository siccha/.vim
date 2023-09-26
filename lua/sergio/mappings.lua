-- Primeagen remaps
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- delete visual into void, then paste
vim.keymap.set("x", "<leader>p", "\"_dP")
-- substitute what's under the cursor
vim.keymap.set("n", "<leader>subst", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

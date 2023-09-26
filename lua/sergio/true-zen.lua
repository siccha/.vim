-- Based on https://github.com/Pocco81/true-zen.nvim/blob/main/lua/true-zen/focus.lua
local M = {}

M.running = false
local cmd = vim.cmd

function M.on()
	cmd("tab split")
	cmd("TabooRename Focus")
	M.running = true
end

function M.off()
	cmd("tabclose")
        cmd("tabprevious")
	M.running = false
end

function M.toggle()
	if M.running then
		M.off()
	else
		M.on()
	end
end

return M

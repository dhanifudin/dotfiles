local status, _ = pcall(require, "impatient")

if not status then
	return
end

if vim.g.vscode ~= nil then
	require("dhanifudin.config.vscode")
else
	require("dhanifudin")
end

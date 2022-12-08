-- vim.cmd("colorscheme gruvbox")

local installed, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not installed then
	print("Colorscheme not found!")
end

local installed, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not installed then
	vim.cmd("colorscheme habamax")
	print("Colorscheme not found!")
end

return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local status, todocomments = pcall(require, "todo-comments")
		if status then
			todocomments.setup({})
		end
	end,
}

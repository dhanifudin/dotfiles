return {
	"nvim-telescope/telescope.nvim",
	event = "BufRead",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
	},
	config = function()
		local status, telescope = pcall(require, "telescope")
		if status then
      telescope.setup({
        pickers = {
          find_files = {
            theme = "ivy",
          },
          live_grep = {
            theme = "ivy"
          }
        },
        extensions = {
          file_browser = {
            theme = "ivy"
          }
        }
      })
			telescope.load_extension("file_browser")

			vim.api.nvim_set_keymap("n", "gof", ":Telescope find_files<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "goF", ":Telescope file_browser<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "gog", ":Telescope live_grep<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "goG", ":Telescope git_stash<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "goc", ":Telescope command_history<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "gob", ":Telescope buffers<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "got", ":Telescope treesitter<cr>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("n", "goT", ":Telescope tags<cr>", { noremap = true, silent = true })
		end
	end,
}
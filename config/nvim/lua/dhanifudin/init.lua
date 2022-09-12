local is_vscode = vim.api.nvim_eval('exists("g:vscode")') == 1

if not is_vscode then
   require('dhanifudin.plugins')
   require('dhanifudin.lsp')
   require('dhanifudin.lspsaga')
   require('dhanifudin.treesitter')
   require('dhanifudin.easymotion')
   require('dhanifudin.mapping')
   require('dhanifudin.config')
   require('dhanifudin.lualine')
   require('dhanifudin.blankline')
   require('dhanifudin.telescope')
   require('dhanifudin.formatter')
end

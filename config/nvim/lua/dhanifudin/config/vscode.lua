require("dhanifudin.config")

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1

  nmap s <Plug>(easymotion-s)
  omap s <Plug>(easymotion-s)
  xmap s <Plug>(easymotion-s)

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "svermeulen/vim-easyclip" })
	use({ "mbbill/undotree" })
	use({ "asvetliakov/vim-easymotion" })
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-unimpaired" })
	use({ "kana/vim-textobj-user" })
	use({ "Julian/vim-textobj-variable-segment" })

	if packer_bootstrap then
		require("packer").install()
	end
end)

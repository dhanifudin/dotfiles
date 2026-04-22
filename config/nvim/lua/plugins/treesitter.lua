-- nvim-treesitter v1: pure parser manager
-- configs.lua is gone; setup() only accepts install_dir
-- Highlighting via Neovim's native vim.treesitter.start()
-- Indentation via nvim-treesitter.indent module

local parsers = {
  "typescript", "tsx", "javascript", "vue", "php", "go", "rust",
  "yaml", "json", "jsonc", "html", "css", "lua", "bash", "markdown",
  "markdown_inline", "toml", "dockerfile", "vim", "vimdoc", "regex",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "VeryLazy", "BufReadPost", "BufNewFile" },
    config = function()
      -- Install missing parsers (async, shows progress only on first run)
      local installed = {}
      for _, p in ipairs(require("nvim-treesitter.config").get_installed("parsers")) do
        installed[p] = true
      end
      local missing = vim.tbl_filter(function(p) return not installed[p] end, parsers)
      if #missing > 0 then
        require("nvim-treesitter.install").install(missing)
      end

      -- Enable highlighting + indentation per filetype via FileType autocmd
      -- pcall: silently skips filetypes with no available parser
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nvim_treesitter", { clear = true }),
        callback = function(ev)
          local ok = pcall(vim.treesitter.start, ev.buf)
          if ok then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}

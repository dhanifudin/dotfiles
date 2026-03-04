return {
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    opts = {},
    init = function()
      -- Silently dismiss E325 when an existing swap file is found for the scratchpad
      vim.api.nvim_create_autocmd("SwapExists", {
        callback = function(ev)
          if ev.match:find("kulala", 1, true) then
            vim.v.swapchoice = "e"
          end
        end,
      })
      -- Prevent swap files being created for kulala buffers going forward
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function()
          vim.opt_local.swapfile = false
        end,
      })
    end,
  },
}

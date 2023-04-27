return {
  "numToStr/Comment.nvim",
  config = function()
    local installed, comment = pcall(require, "Comment")
    if installed then
      comment.setup()
    end
  end,
}
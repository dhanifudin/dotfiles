return {
  "numToStr/Comment.nvim",
  config = function()
    local status, comment = pcall(require, "Comment")
    if status then
      comment.setup()
    end
  end,
}

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = "cd app && npm install --package-lock=false",
  keys = {
    { "<leader>cp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown Preview Toggle" },
  },
}

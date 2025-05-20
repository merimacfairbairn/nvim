return {
  "3rd/image.nvim",
  ft = { "markdown", "vimwiki", "css", "html", "htmldjango" },
  opts = {
    integrations = {
      markdown = {
        only_render_image_at_cursor = true,
        only_render_image_at_cursor_mode = "inline",
      },
    },
  },
}

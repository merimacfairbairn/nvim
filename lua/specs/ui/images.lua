return {
  "3rd/image.nvim",
  ft = { "markdown", "vimwiki", "css", "html", "htmldjango" },
  opts = {
    backend = "kitty",
    integrations = {
      markdown = {
        enabled = true,
        only_render_image_at_cursor = true,
        only_render_image_at_cursor_mode = "inline",
        download_remote_images = true,
      },
    },

    max_width = 500,
    max_height = 500,
    max_height_window_percentage = math.huge,
    max_width_window_percentage = math.huge,
    window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "noice", "" },
  },
}

function ColorDefault(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)
end

ColorDefault()

return {
  "michaelb/sniprun",
  branch = "master",

  build = "sh install.sh",

  ft = { "markdown", "org" },
  config = function()
    require("sniprun").setup({})
  end,
}

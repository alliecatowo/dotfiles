return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true, -- let Ghostty's background show through
      italic_comment = true,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "dracula" } },
}

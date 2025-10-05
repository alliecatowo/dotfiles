return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false }, -- Use dashboard-nvim instead
      explorer = { enabled = false }, -- Use neo-tree instead
      picker = {
        sources = {
          explorer = { enabled = false }, -- Disable explorer picker source
        },
      },
    },
  },
}

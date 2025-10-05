return {
  -- Rainbow indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },

  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- Scrollbar with git signs
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      handle = {
        color = "#6272a4",
      },
      marks = {
        Error = { color = "#ff5555" },
        Warn = { color = "#f1fa8c" },
        Info = { color = "#8be9fd" },
        Hint = { color = "#50fa7b" },
        Misc = { color = "#bd93f9" },
        GitAdd = { color = "#50fa7b" },
        GitChange = { color = "#f1fa8c" },
        GitDelete = { color = "#ff5555" },
      },
      handlers = {
        gitsigns = true,
        search = false, -- Disable search handler (requires hlslens)
      },
    },
  },

  -- Colorizer - shows hex colors
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
      },
    },
  },

  -- Better UI for input and select
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
}

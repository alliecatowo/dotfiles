return {
  -- Add dracula colorscheme
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        colors = {
          bg = "#282A36",
          fg = "#F8F8F2",
          selection = "#44475A",
          comment = "#6272A4",
          red = "#FF5555",
          orange = "#FFB86C",
          yellow = "#F1FA8C",
          green = "#50fa7b",
          purple = "#BD93F9",
          cyan = "#8BE9FD",
          pink = "#FF79C6",
          bright_red = "#FF6E6E",
          bright_green = "#69FF94",
          bright_yellow = "#FFFFA5",
          bright_blue = "#D6ACFF",
          bright_magenta = "#FF92DF",
          bright_cyan = "#A4FFFF",
          bright_white = "#FFFFFF",
          menu = "#21222C",
          visual = "#3E4452",
          gutter_fg = "#4B5263",
          nontext = "#3B4048",
          white = "#ABB2BF",
          black = "#191A21",
        },
        show_end_of_buffer = true,
        transparent_bg = true, -- Enable transparency
        lualine_bg_color = "#44475a",
        italic_comment = true,
        overrides = {
          -- Make special UI elements stand out
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "#21222C" },
          FloatBorder = { fg = "#BD93F9" },
          TelescopeNormal = { bg = "#21222C" },
          TelescopeBorder = { fg = "#BD93F9" },
          -- Rainbow colors for delimiters
          RainbowDelimiterRed = { fg = "#FF5555" },
          RainbowDelimiterYellow = { fg = "#F1FA8C" },
          RainbowDelimiterBlue = { fg = "#8BE9FD" },
          RainbowDelimiterOrange = { fg = "#FFB86C" },
          RainbowDelimiterGreen = { fg = "#50fa7b" },
          RainbowDelimiterViolet = { fg = "#BD93F9" },
          RainbowDelimiterCyan = { fg = "#8BE9FD" },
          -- Dashboard colors
          DashboardHeader = { fg = "#BD93F9" },
          DashboardCenter = { fg = "#8BE9FD" },
          DashboardFooter = { fg = "#6272A4", italic = true },
          -- Indent guides
          IndentBlanklineChar = { fg = "#44475A" },
          IndentBlanklineContextChar = { fg = "#BD93F9" },
        },
      })
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- Configure LazyVim to load dracula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}

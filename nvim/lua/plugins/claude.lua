return {
  -- Claude Code integration using CLI (no API key needed)
  {
    "coder/claudecode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    opts = {
      -- Uses the 'claude' command from mise
      auto_reload = true,
      terminal = {
        position = "bottom",
      },
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
      { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
    },
  },
}

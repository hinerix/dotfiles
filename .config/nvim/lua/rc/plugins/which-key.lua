return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
  keys = {
    {
      "<Leader>?",
      function()
        local wk = require("which-key")
        wk.show({ global = true })
      end,
      desc = "Global Keymaps (which-key)",
    },
    {
      "<Leader>?l",
      function()
        local wk = require("which-key")
        wk.show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<Leader>t", group = "Tab" },
      { "<Leader>b", group = "Buffer" },
      { "<Leader>e", group = "Tree" },
      { "<Leader>j", group = "Jump" },
      { "<Leader>s", group = "Session" },
      { "<Leader>f", group = "Telescope" },
    })
  end,
}


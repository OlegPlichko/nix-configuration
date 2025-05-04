return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "qwen",
        },
        cmd = {
          adapter = "qwen",
        }
      },
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              api_key = "YOUR_ATHROPIC_API_KEY_HERE",
            },
          })
        end,
        qwen = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen",
            schema = {
              model = {
                default = "qwen2.5:1.5b",
              },
            },
          })
        end,
      },
    }) 
  end
}

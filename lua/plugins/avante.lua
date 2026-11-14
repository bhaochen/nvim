return {
  {
    "yetone/avante.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "ColinKennedy/mega.cmdparse",
        dependencies = {
          "ColinKennedy/mega.logging",
        },
      },
    },

    opts = {
      provider = "groq",

      providers = {
        groq = {
          __inherited_from = "openai",
          api_key_name = "GROQ_API_KEY",
          endpoint = "https://api.groq.com/openai/v1",
          model = "qwen/qwen3.8-27b",
          timeout = 30000,

          extra_request_body = {
            temperature = 0.6,
            max_completion_tokens = 8192,
          },
        },
      },
    },
  },
}

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
      mode = "legacy",
      override_prompt_dir = vim.fn.stdpath("config") .. "/lua/plugins/avante_prompts",

      behaviour = {
        auto_add_current_file = false,
      },

      providers = {
        groq = {
          __inherited_from = "openai",
          api_key_name = "GROQ_API_KEY",
          endpoint = "https://api.groq.com/openai/v1",
          model = "qwen/qwen3.8-27b",
          timeout = 30000,
          disable_tools = true,
          proxy = "http://127.0.0.1:10808",

          extra_request_body = {
            temperature = 0.6,
            max_completion_tokens = 16384,
          },
        },
      },
    },

    config = function(_, opts)
      require("avante").setup(opts)

      local prompts = require("avante.utils.prompts")
      prompts.get_agents_rules_prompt = function() return nil end
      prompts.get_cursor_rules_prompt = function() return nil end
    end,
  },
}

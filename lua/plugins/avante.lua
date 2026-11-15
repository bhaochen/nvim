local function lines_slash_command()
  return {
    name = "lines",
    shorthelp = "Ask a question about specific lines",
    description = "/lines <start>-<end> <question>",
    details = "Ask a question about specific lines\n/lines <start>-<end> <question>",
    callback = function(sidebar, args, cb)
      local first, last, question = args:match("^%s*(%d+)%s*%-%s*(%d+)%s+(.-)%s*$")
      if not first or question == "" then
        vim.notify("Usage: /lines <start>-<end> <question>", vim.log.levels.WARN)
        return
      end

      first, last = tonumber(first), tonumber(last)
      if first > last then first, last = last, first end

      local bufnr = sidebar.code.bufnr
      if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
        vim.notify("No source buffer for /lines", vim.log.levels.WARN)
        return
      end

      local filepath = vim.api.nvim_buf_get_name(bufnr)
      if filepath == "" then
        vim.notify("Save the buffer before using /lines", vim.log.levels.WARN)
        return
      end

      local total = vim.api.nvim_buf_line_count(bufnr)
      first = math.max(1, math.min(first, total))
      last = math.max(first, math.min(last, total))

      local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, first - 1, last, false)
      if not ok or not lines or #lines == 0 then
        vim.notify("Failed to read lines for /lines", vim.log.levels.WARN)
        return
      end

      local SelectionResult = require("avante.selection_result")
      local Range = require("avante.range")
      sidebar.code.selection = SelectionResult:new(
        filepath,
        vim.api.nvim_get_option_value("filetype", { buf = bufnr }),
        table.concat(lines, "\n"),
        Range:new({ lnum = first, col = 1 }, { lnum = last, col = #lines[#lines] + 1 })
      )

      if cb then cb(string.format("%d-%d %s", first, last, question)) end
    end,
  }
end

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

      require("avante.config").slash_commands = { lines_slash_command() }
    end,
  },
}

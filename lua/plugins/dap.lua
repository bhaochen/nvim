local api = vim.api

--- 轮询等待 dap 终端的窗口稳定下来，然后聚焦并进入 insert 模式
---@param get_buf fun():integer? 取 dap 终端 buffer 的函数（终端是异步创建的）
local function focus_dap_terminal(get_buf)
  local win, stable, tries = nil, 0, 40
  local function step()
    tries = tries - 1
    local buf = get_buf()
    local found
    if buf and api.nvim_buf_is_valid(buf) then
      for _, w in ipairs(api.nvim_list_wins()) do
        if api.nvim_win_get_buf(w) == buf then
          found = w
          break
        end
      end
    end
    -- dap-ui 打开侧边栏时会关掉 dap 自己开的终端窗口，再把终端挪进侧边栏，
    -- 所以要连续几次都指向同一个窗口，确认布局稳定了再切过去
    stable = found and found == win and stable + 1 or 0
    win = found
    if win and stable >= 4 then
      api.nvim_set_current_win(win)
      pcall(api.nvim_command, "startinsert")
    elseif tries > 0 then
      vim.defer_fn(step, 50)
    end
  end
  step()
end

return {
  {
    "mfussenegger/nvim-dap",
    -- 每开一个新的调试会话，就自动切到 dap 的 terminal 终端并进入 insert 模式，
    -- 方便直接给被调试程序输入内容；续跑 / 单步已有会话不会打断你。
    init = function()
      -- init 执行时 nvim-dap 还没加载完，推到下一次主循环再挂监听
      vim.schedule(function()
        local dap = require("dap")
        dap.listeners.after.event_initialized["focus_terminal"] = function(session)
          focus_dap_terminal(function()
            return session.term_buf
          end)
        end
      end)
    end,
  },
}

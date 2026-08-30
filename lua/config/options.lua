-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.vimtex_view_method = "zathura_simple"

-- Use dedicated venv for Neovim Python provider (pynvim, jupyter_client, etc.)
-- Created via: uv venv ~/.local/share/nvim-venv && uv pip install --python ~/.local/share/nvim-venv/bin/python pynvim jupyter_client ipykernel jupytext
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim-venv/bin/python")

-- Disable unused providers to suppress checkhealth warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

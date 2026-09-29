-- Put the plugin-install `git` shim first on PATH so GitHub clones go through
-- the local proxy and are retried on transient TLS failures. Scoped to Neovim
-- only — git in your shell is untouched. See bin/git for the full story.
vim.env.PATH = vim.fn.stdpath("config") .. "/bin:" .. vim.env.PATH

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

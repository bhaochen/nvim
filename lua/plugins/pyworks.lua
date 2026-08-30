return {
  {
    "jeryldev/pyworks.nvim",
    dependencies = {
      {
        "GCBallesteros/jupytext.nvim",
        config = false, -- Let pyworks handle jupytext configuration
      },
      "jeryldev/molten-nvim",
      "3rd/image.nvim",
    },
    config = function()
      require("pyworks").setup({
        python = {
          use_uv = true, -- Use uv for faster package installation
        },
        image_backend = "kitty", -- or "ueberzug" for other terminals
        skip_jupytext = true, -- suppress false conflict warning; pyworks handles jupytext via CLI
      })
    end,
    lazy = false,
    priority = 100,
  },
}

-- uv add pynvim ipykernel jupyter_client jupytext
-- <leader> + vs

--
-- Execute code:
--
--     <leader>jl - Auto-initialize kernel
--     <leader>jj - Run current cell and move to next (Shift+Enter in Jupyter)
--
-- Create new cells:
--
--     <leader>ja - Insert code cell above
--     <leader>jb - Insert code cell below
--     <leader>jma - Insert markdown cell above
--
-- Package management:
--
--     Missing packages detected automatically
--     Press <leader>pi to install missing packages
--     Or use :PyworksAdd numpy pandas matplotlib

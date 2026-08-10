return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      styles = {
        comments = { italic = true },
        keywords = { italic = false },
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
      vim.g.tmux_navigator_save_on_switch = 2
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, options)
      vim.list_extend(options.ensure_installed, {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        cssls = {},
        html = {},
        jsonls = {},
        lua_ls = {},
        marksman = {},
        basedpyright = {},
        vtsls = {},
        yamlls = {},
      },
    },
  },
}

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

vim.notify = require("notify")

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Startup
  use({
    "startup-nvim/startup.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("startup").setup({ theme = "startify" })
    end
  })

  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    config = function()
      require("markdown-preview").setup {}
    end,
  })

  -- Fuzzy finder
  use({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })

  -- Theme
  use({
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup {}
    end,
  })

  -- Which-Key
  use {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup {
      }
    end
  }

  use({
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {}
    end
  })

  use({
    'nvim-tree/nvim-web-devicons',
  })

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require("lualine").setup {}
    end
  })


  use({
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
    end,
  })

  use({
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup {
      }
    end,
  })

  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        icons = false,
      }
    end
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  })

  use({ "nvim-treesitter/playground" })
  use({ "theprimeagen/harpoon" })
  use({ "mbbill/undotree" })
  use({ "tpope/vim-fugitive" })
  use({ "nvim-treesitter/nvim-treesitter-context" })
  use({ "wakatime/vim-wakatime" })

  -- LSP ------------------------------------------------------------------
  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  })
  -----------------------------------------------------------------------------
  use({ 'rcarriga/nvim-notify' })

  use({ "github/copilot.vim" })

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }

  use({ 'sheerun/vim-polyglot' })

  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  }
end)

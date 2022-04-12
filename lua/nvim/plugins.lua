local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- git
  use {
    { 'airblade/vim-gitgutter' },
    { 'tpope/vim-fugitive' },
  }

  -- quality of life
  use {
    { 'AndrewRadev/linediff.vim' },
    { 'chrisbra/NrrwRgn' },
    { 'junegunn/vim-easy-align' },
    { 'justinmk/vim-dirvish' },
    { 'kevinhwang91/nvim-bqf' },
    { 'ludovicchabant/vim-gutentags' },
    { 'majutsushi/tagbar', cmd = 'TagbarToggle' },
    { 'mbbill/undotree', cmd = 'UndotreeToggle', },
    { 'romainl/vim-qf' },
    { 'romainl/vim-qlist' },
    { 'tpope/vim-scriptease' },
    { 'tversteeg/registers.nvim', keys = { { 'n', '"' }, { 'i', '<c-r>' } } },
    { 'wellle/targets.vim' },
  }

  -- objects and stuf
  use {
    { 'tpope/vim-commentary' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-unimpaired' },
  }

  -- other utils
  use {
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
  }

  -- lsp, completion
  use {
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/vim-vsnip' },
    { 'neovim/nvim-lspconfig' },
    { 'quangnguyen30192/cmp-nvim-tags' },
    { 'rafamadriz/friendly-snippets' },
  }

  -- languages
  use {
    { 'chrisbra/csv.vim' },
    { 'fatih/vim-go' },
    { 'rust-lang/rust.vim' },
    { 'mfulz/cscope.nvim' },
    { 'tpope/vim-rails' },
  }

  -- visuals
  use {
    { 'sainnhe/edge' },
    { 'sainnhe/gruvbox-material' },
    { 'sainnhe/sonokai' },
    { 'vim-airline/vim-airline' },
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

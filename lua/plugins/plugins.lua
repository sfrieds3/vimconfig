local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- git
  use {
    { 'tpope/vim-fugitive', cmd = { 'Git' }, disable = true },
    { 'airblade/gitgutter' }
  }

  -- quality of life
  use {
    { 'wellle/targets' },
    { 'mbbill/undotree',
      cmd = 'UndotreeToggle', },
    { 'majutsushi/tagbar',
      cmd = 'TagbarToggle' },
    { 'romainl/vim-qlist' },
    { 'junegunn/vim-easy-align' },
    { 'vim-scriptease' }, 
    { 'AndrewRadev/linediff' },
    { 'ludovicchabant/vim-gutentags' },
    { 'romainl/vim-qf' },
    { '' },
  }

  -- other utils
  use { 
    { 'junegunn/fzf' },
    { 'junegunn/fzf.vim' },
  }

  -- lsp, completion
  use {
    { '
  }

  -- languages
  use {
    { 'tpope/vim-rails' },

  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

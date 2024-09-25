local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- git stuff
Plug('tpope/vim-fugitive')
Plug('lewis6991/gitsigns.nvim')
Plug('tpope/vim-rhubarb')

Plug('junegunn/fzf', { ['do'] = function()
  vim.fn['fzf#install']()
end })
Plug('junegunn/fzf.vim')

Plug('scrooloose/nerdtree')
Plug('romgrk/barbar.nvim')

Plug('tanvirtin/monokai.nvim')

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = function()
	vim.cmd('TSUpdate')
end })
--Plug 'p00f/nvim-ts-rainbow'

Plug('github/copilot.vim')

Plug('neovim/nvim-lspconfig')

Plug('psf/black', { ['branch'] = 'stable' })

vim.call('plug#end')

---------------------------

vim.wo.number = true

vim.cmd("colorscheme monokai_soda")


require('gitsigns').setup()

vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
vim.keymap.set("n", "<C-p>", ":Files<CR>")
vim.keymap.set("n", "<C-l>", ":Buffers<CR>")

vim.filetype.add({
  extension = {
    tf = 'hcl',
    tfvars = 'hcl',
  }
  })

require'barbar'.setup {
  auto_hide = 1,
  icons = {
      button = 'x',
      filetype = {enabled = false}},
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "python", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }
}

require'lspconfig'.pyright.setup{}

vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")
-- cno = command mode
-- <expr> = when set this is an "expression" that will look for the next "token" (%% in this case) and replace it with the
-- rest of the expression
-- maybe this is what I want?
--vim.keymap.set("cnoremap", "<expr> $$", "expand('%:h').'/'")


-- configure tf files to use hcl
vim.filetype.add({
  extension = {
    tf = 'hcl',
    tfvars = 'hcl',
  }
})

-- tell nvim to use it's own venv with pynvim installed
vim.g.python3_host_prog = '/Users/wellis/venvs/neovim/bin/python3.12'
-- configure black to not use virtualenv
vim.g.black_use_virtualenv = 0

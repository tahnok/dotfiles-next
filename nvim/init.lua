local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- git stuff
Plug('tpope/vim-fugitive')
Plug('shumphrey/fugitive-gitlab.vim')
Plug('lewis6991/gitsigns.nvim')
Plug('tpope/vim-rhubarb')

--Plug('junegunn/fzf', { ['do'] = function()
--  vim.fn['fzf#install']()
--end })
--Plug('junegunn/fzf.vim')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { ['branch'] = '0.1.x'})

Plug('scrooloose/nerdtree')
Plug('romgrk/barbar.nvim')

Plug('tanvirtin/monokai.nvim')
Plug('EdenEast/nightfox.nvim')

Plug('tpope/vim-rails')

Plug('nvim-treesitter/nvim-treesitter', {
	['do'] = function()
		vim.cmd('TSUpdate')
	end,
        -- pin to master for neovim 0.11, change to main after upgrade
	['branch'] = 'master'
})
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'
--Plug 'p00f/nvim-ts-rainbow'

Plug('github/copilot.vim')

Plug('neovim/nvim-lspconfig')

Plug('lukas-reineke/indent-blankline.nvim')

vim.call('plug#end')

---------------------------

vim.wo.number = true

vim.cmd("colorscheme nightfox")

require('gitsigns').setup()

--vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'
--vim.keymap.set("n", "<C-p>", ":Files<CR>")
--vim.keymap.set("n", "<C-l>", ":Buffers<CR>")

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set("n", "<C-l>", builtin.grep_string, { desc = 'Telescope grep string under cursor' })

-- add alias for :Rg to Telescope live_grep
vim.cmd("command! -nargs=* Rg lua require('telescope.builtin').live_grep({ search = <q-args> })")


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
    filetype = {enabled = false}
  },
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {"python", "vimdoc", "luadoc", "ruby", "go", "graphql"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
  },

  -- doesn't work good for ruby https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
  indent = {
    enable = false
  }
}


vim.lsp.config('ruby_lsp', {
  cmd_env = {
    -- Ignore bad sorbet config
    RUBY_LSP_BYPASS_TYPECHECKER = 'true',
  },
  init_options = {
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
})
vim.lsp.enable('ruby_lsp')

vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")
-- cno = command mode
-- <expr> = when set this is an "expression" that will look for the next "token" (%% in this case) and replace it with the
-- rest of the expression
-- maybe this is what I want?
--vim.keymap.set("cnoremap", "<expr> $$", "expand('%:h').'/'")



require("ibl").setup()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)


-- map gF to :Rg <C-R><C-W>
map('n', 'gF', ':Rg <C-R><C-W><CR>', opts)

-- disable ruby mappings that conflict with ruby-lsp I think, from rando comment.
vim.g.no_ruby_maps = true

-- set unnamed register to clipboard, yanking/deleting to system clipboard by default
--vim.cmd("set clipboard+=unnamedplus")

-- enable diagnostics in virtual lines, instead of end of line
-- vim.diagnostic.config({
  -- virtual_lines = true
-- })


-- default indent of 2
vim.o.shiftwidth = 2
-- use spaces when inserting tabs
vim.o.expandtab = true
-- treat tab as 2 spaces
vim.o.softtabstop = 2

-- this is the number of spaces a <Tab> counts for while performing editing operations
-- and for what it looks like. Leaveing it ot 8 for now so you can see tabs
--vim.o.tabstop = 2

-- be smart about indent for c like languages?
-- vim.o.smartindent = true

local vim = vim

-- maybe time to find a new plugini manager? does nvim have one?
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- git stuff
Plug('tpope/vim-fugitive', { ['commit'] = '3b753cf8c6a4dcde6edee8827d464ba9b8c4a6f0' })
Plug('shumphrey/fugitive-gitlab.vim', { ['commit'] = '3584cf7e607ba7822f991d407a8d780e05aae287' })
Plug('lewis6991/gitsigns.nvim', { ['commit'] = 'dd3f588bacbeb041be6facf1742e42097f62165d' })
Plug('tpope/vim-rhubarb', { ['commit'] = '5496d7c94581c4c9ad7430357449bb57fc59f501' })

Plug('nvim-lua/plenary.nvim', { ['commit'] = '74b06c6c75e4eeb3108ec01852001636d85a932b' })
Plug('nvim-telescope/telescope.nvim', { ['release'] = '0.2.2', ['commit'] = '7d324792b7943e4aa16ad007212e6acc6f9fe335' })

Plug('scrooloose/nerdtree', { ['commit'] = '690d061b591525890f1471c6675bcb5bdc8cdff9' })
Plug('romgrk/barbar.nvim', { ['commit'] = 'a4bef5b4fc1f064f2f673172252028eae18191c9' })

--Plug('tanvirtin/monokai.nvim', { ['commit'] = 'b8bd44d5796503173627d7a1fc51f77ec3a08a63' })
--Plug('EdenEast/nightfox.nvim', { ['commit'] = '26b61b1f856ec37cae3cb64f5690adb955f246a1' })
--Plug('f4z3r/gruvbox-material.nvim', { ['commit'] = 'ee006c962780358b8f03eaa918a3139b7c6f0d81' })
Plug('miikanissi/modus-themes.nvim', { ['commit'] = '56233f0986ef6c8d0eab97e924e87144e584d970' })

-- adds :A for switching between rails file and test
Plug('tpope/vim-rails', { ['commit'] = 'b0a5c76f86ea214ade36ab0b811e730c3f0add67' })

Plug('nvim-treesitter/nvim-treesitter', {
	['do'] = function()
		vim.cmd('TSUpdate')
	end,
	['branch'] = 'main',
	['commit'] = '4916d6592ede8c07973490d9322f187e07dfefac'
})
-- some cool selection thing I totally forgot about
Plug('nvim-treesitter/nvim-treesitter-textobjects', { ['commit'] = '851e865342e5a4cb1ae23d31caf6e991e1c99f1e' })

Plug('github/copilot.vim', { ['commit'] = 'a12fd5672110c8aa7e3c8419e28c96943ca179be' })

Plug('neovim/nvim-lspconfig', { ['commit'] = '246572944c2a1e2a646c2e7609ff619b0fe74c18' })

-- add visual ident lines, like in vscode
Plug('lukas-reineke/indent-blankline.nvim', { ['commit'] = 'd28a3f70721c79e3c5f6693057ae929f3d9c0a03' })

vim.call('plug#end')

---------------------------

vim.cmd([[colorscheme modus]]) -- modus_operandi, modus_vivendi

vim.wo.number = true

--require('gruvbox-material').setup({
--  contrast = 'hard',
--  italics = true,
--})
--vim.cmd.colorscheme('gruvbox-material')

require('gitsigns').setup()

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

require'nvim-treesitter'.setup {
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
    DISABLE_SPRING = "1",
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

-- make %% expand to current file's dir
vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")


-- indent blankline
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
vim.diagnostic.config({
  virtual_text = true,
--  virtual_lines = true
})


-- default indent of 2
vim.o.shiftwidth = 2
-- use spaces when inserting tabs
vim.o.expandtab = true
-- treat tab as 2 spaces
vim.o.softtabstop = 2

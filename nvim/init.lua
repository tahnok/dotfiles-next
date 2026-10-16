-- Plugins are managed by the built-in vim.pack (:h vim.pack). Exact revisions
-- live in nvim-pack-lock.json next to this file, update with
-- :lua vim.pack.update(), review the diff, then :write to apply or :quit to bail.

-- must be registered before vim.pack.add() so it also fires on install
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add({
  -- git stuff
  gh('tpope/vim-fugitive'),
  gh('shumphrey/fugitive-gitlab.vim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('tpope/vim-rhubarb'),

  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope.nvim'),

  gh('preservim/nerdtree'),
  gh('romgrk/barbar.nvim'),

  gh('miikanissi/modus-themes.nvim'),

  -- adds :A for switching between rails file and test
  gh('tpope/vim-rails'),

  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },

  gh('neovim/nvim-lspconfig'),

  -- add visual ident lines, like in vscode
  gh('lukas-reineke/indent-blankline.nvim'),
})

---------------------------

vim.cmd([[colorscheme modus]]) -- modus_operandi, modus_vivendi

vim.wo.number = true
-- always show the sign column so gitsigns/diagnostics don't shift text sideways
vim.o.signcolumn = 'yes'

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set("n", "<C-l>", builtin.grep_string, { desc = 'Telescope grep string under cursor' })

-- :Rg [text] opens Telescope live_grep, prefilled with text
vim.api.nvim_create_user_command('Rg', function(cmd)
  builtin.live_grep({ default_text = cmd.args })
end, { nargs = '*', desc = 'Telescope live_grep' })

-- like <C-l> but lands in live_grep so the query can be edited
vim.keymap.set('n', 'gF', function()
  builtin.live_grep({ default_text = vim.fn.expand('<cword>') })
end, { desc = 'Telescope live_grep word under cursor' })

require'barbar'.setup {
  auto_hide = 1,
  icons = {
    button = 'x',
    filetype = {enabled = false}
  },
}

vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')
for i = 1, 9 do
  vim.keymap.set('n', '<A-' .. i .. '>', '<Cmd>BufferGoto ' .. i .. '<CR>')
end
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')

---------------------------
-- git

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- ]c / [c jump between hunks (falls back to the builtin in diff mode)
    map('n', ']c', function()
      if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gitsigns.nav_hunk('next') end
    end, 'Next hunk')
    map('n', '[c', function()
      if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gitsigns.nav_hunk('prev') end
    end, 'Previous hunk')

    -- gh* = "git hunk"
    map('n', 'ghs', gitsigns.stage_hunk, 'Stage/unstage hunk')
    map('n', 'ghr', gitsigns.reset_hunk, 'Reset hunk')
    map('x', 'ghs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage lines')
    map('x', 'ghr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset lines')
    map('n', 'ghp', gitsigns.preview_hunk_inline, 'Preview hunk inline')
    map('n', 'ghb', function() gitsigns.blame_line({ full = true }) end, 'Blame line')
    map('n', 'ghd', gitsigns.diffthis, 'Diff against index')

    -- ih = "inner hunk", e.g. dih deletes the hunk, vih selects it
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Select hunk')
  end,
}

---------------------------
-- treesitter

-- treesitter main branch: install parsers (async, skips already installed), highlighting is enabled per filetype
-- indent is left off, doesn't work good for ruby https://github.com/nvim-treesitter/nvim-treesitter/issues/3363
require'nvim-treesitter'.install {"python", "vimdoc", "luadoc", "ruby", "go", "graphql"}

vim.api.nvim_create_autocmd('FileType', {
  pattern = {"python", "ruby", "go", "graphql"},
  callback = function() vim.treesitter.start() end,
})

-- disable ruby mappings that conflict with ruby-lsp I think, from rando comment.
vim.g.no_ruby_maps = true

---------------------------
-- completion

-- built-in autocomplete: popup as you type, from words in open buffers.
-- <C-n>/<C-p> to move, <C-y> to accept, <C-e> to dismiss
vim.o.autocomplete = true
vim.o.complete = '.^5,w^5,b^5,u^5'
vim.o.completeopt = 'menuone,noselect,fuzzy,popup'

-- once a language server attaches, add it as the first autocomplete source.
-- completion.enable() makes <C-y> apply extras like auto-imports and snippets.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf)
      vim.bo[ev.buf].complete = 'o,' .. vim.o.complete
    end
  end,
})

---------------------------
-- lsp

--vim.lsp.config('ruby_lsp', {
--  cmd_env = {
--    -- Ignore bad sorbet config
--    RUBY_LSP_BYPASS_TYPECHECKER = 'true',
--    DISABLE_SPRING = "1",
--  },
--  init_options = {
--    addonSettings = {
--      ["Ruby LSP Rails"] = {
--        enablePendingMigrationsPrompt = false,
--      },
--    },
--  },
--})
--vim.lsp.enable('ruby_lsp')

vim.diagnostic.config({
  virtual_text = true,
  -- show diagnostics on their own lines below the code instead
  -- virtual_lines = true
})

---------------------------
-- misc

-- make %% expand to current file's dir
vim.cmd("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'")

-- indent blankline
require("ibl").setup()

-- set unnamed register to clipboard, yanking/deleting to system clipboard by default
--vim.cmd("set clipboard+=unnamedplus")

-- default indent of 2
vim.o.shiftwidth = 2
-- use spaces when inserting tabs
vim.o.expandtab = true
-- treat tab as 2 spaces
vim.o.softtabstop = 2

call plug#begin(stdpath('data') . '/plugged')

"Git stuff
Plug 'tpope/vim-fugitive' 
Plug 'airblade/vim-gitgutter'
"Github vim extension
Plug 'tpope/vim-rhubarb'

"Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'scrooloose/nerdtree'
Plug 'romgrk/barbar.nvim'

"Fuzzy find / matching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tanvirtin/monokai.nvim'
call plug#end()

"disable icons for barbar
let bufferline = get(g:, 'bufferline', {})
let bufferline.icons = v:false

syntax on
colorscheme monokai_soda

"show line numbers
set number

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" map Ctrl p to :Files from fzf.vim
nnoremap <C-p> :Files<CR>

" %% to folder containing current file at command
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Try making things update fast?
set updatetime=300

"CoC things
nmap <silent> gd <Plug>(coc-definition)

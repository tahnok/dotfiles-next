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
" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>

syntax on
colorscheme monokai_soda

"make clicking on splits and tabs work
set mouse+=a

"show line numbers
set number

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let mapleader=" "
nnoremap <leader>b :Buffers<cr>

" map Ctrl p to :Files from fzf.vim
nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Rg <C-R><C-w><CR>
nnoremap <leader>g :Files <C-R><C-w><CR>

" %% to folder containing current file at command
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"Try making things update fast?
set updatetime=300

"CoC things
nmap <silent> gd <Plug>(coc-definition)

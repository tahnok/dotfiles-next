call plug#begin(stdpath('data') . '/plugged')
Plug 'tpope/vim-fugitive' 
Plug 'tpope/vim-rhubarb'
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
call plug#end()

syntax on

set number

" map Ctrl p to :Files from fzf.vim
nnoremap <C-p> :Files<CR>

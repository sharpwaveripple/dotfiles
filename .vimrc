call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'goldfeld/vim-seek'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'davidhalter/jedi-vim'
Plug 'jalvesaq/Nvim-R'
Plug 'ajmwagar/vim-deus'
Plug 'flazz/vim-colorschemes'
Plug 'epeli/slimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-jedi'
call plug#end()

" add line numbers for help files
autocmd FileType help setlocal number
set number relativenumber
set clipboard=unnamed

set path+=**

" clear highlighting with esc
nnoremap <esc> :noh<return><esc>
 
" use jk to exit insert mode
imap jk <Esc>
imap kj <Esc>

set background=dark
colors deus
let g:airline_theme='deus'

" switch between splits easily
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Use the space key to toggle folds
nnoremap <space> za
vnoremap <space> zf

" move between buffers with tab
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>

set autowrite

let g:airline#extensions#tabline#enabled = 1
let g:deoplete#enable_at_startup = 1

" use tab to cycle
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures_delay = 100
autocmd FileType python setlocal completeopt-=preview
let g:NERDTreeWinPos = "left"
let NERDTreeShowLineNumbers = 1
let g:airline_powerline_fonts = 1
let g:NERDTreeWinSize = 25
" autocmd VimEnter * NERDTree " launch NERDTree on start
autocmd VimEnter * wincmd p  " start cursor in editor
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif "close NERDTree if script closes

set tabstop=4 " tab is 4 spaces
set softtabstop=4 " backspace removes a tab
set shiftwidth=4
set textwidth=79
set smarttab
set expandtab

map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>

let R_assign_map = "--"
let R_rconsole_width = 1000
let R_min_editor_width = 80
let R_show_args = 2

au BufNewFile,BufRead *.R,*.sh
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" kill arrow keys...
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down> <NOP>

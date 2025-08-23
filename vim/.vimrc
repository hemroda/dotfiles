"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/autoload/plugged')

  " Theme
  Plug 'morhetz/gruvbox'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Remap Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setting leader key to comma
let mapleader = ','
" Source vimrc file
nmap <leader>sv :source ~/.vimrc<CR>
" Open vimrc file in new buffer for quick edit
nmap ,ev :tabedit ~/dotfiles/vim/.vimrc<CR>
" Open plugins file in new buffer for quick edit
" nmap ,ep :tabedit ~/dotfiles/vim/plugins.vim<CR>


" ------------------------ FILES ------------------------------
" Close file
nmap <leader>q :q<CR>
nmap <leader>Q :q!<CR>

" Save file
nmap <leader>w :w<CR>
nmap <c-s> :w<CR>
imap <c-s> <ESC>:w<CR>

" ------------------------ TABS ------------------------------
" Tab to switch buffers in Normal mode
map <leader>t<leader> :tabnext<CR>
map <leader>tn :tabnew<CR>
" Move current tab to the end
map <leader>tme :tabmove<CR>
" Move current tab to the a specific position (needs to be specified)
map <leader>tm :tabmove
" Close current tab.
map <leader>tc :tabclose<CR>
" Close all OTHER tabs (leave ONLY currently selected tab)
map <leader>to :tabonly<CR>
" indent/unindent with tab/shift-tab in visual mode
xnoremap > >gv
xnoremap < <gv


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Theme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype indent on
filetype plugin on
set background=dark
syntax on
set termguicolors
colorscheme gruvbox

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Config
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set number
set relativenumber
" Enable highlighting of the current line
set cursorline
" Reload files changed outside vim
set autoread
" Automatically write the file when switching buffers
set autowriteall
set updatetime=100

" ===================== Show whitespaces ======================
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" ==================== Split management =======================
" Where to put new splits
set splitright
set splitbelow

" How to navigate btw the splits
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" ========================= Search ============================
" Find the next match as we type the search
set incsearch
" Highlight searches by default
set hlsearch
" Ignore case when searching...
set ignorecase
" ...unless we type a capital
set smartcase
" Add simple highlight removal after search.
nmap <leader><space> :nohlsearch<cr>
" After searching, pressing escape stops the highlight
nmap <ESC> :noh<CR>


set number 		" Show the absolute line numbers
set relativenumber 	" Display relative line numbers
set clipboard=unnamed   " Global yanking with the OS's clipboard
set laststatus=2

" =================== Turn Off Swap Files ====================
set noswapfile
set nobackup
set nowb

" Snippets
augroup markdown_snippets
    autocmd!
    " Simple code block
    autocmd FileType markdown inoremap <buffer> cb ```<CR><CR>```<CR><Up><Up>
    " Shell code block
    autocmd FileType markdown inoremap <buffer> cbs ```sh<CR><CR>```<CR><Up><Up>
    " Python code block
    autocmd FileType markdown inoremap <buffer> cbp ```python<CR><CR>```<CR><Up><Up>
augroup END



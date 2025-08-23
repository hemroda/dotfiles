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
  Plug 'vim-airline/vim-airline'
  Plug 'kien/rainbow_parentheses.vim'

  " Search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'


  " Helpful tools
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'alvan/vim-closetag'
  Plug 'tpope/vim-surround'

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


" ====================== Indentation =========================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" Expand tabs to spaces
set expandtab
" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:.
" Wrap lines at convenient points
set linebreak

" ================== Backups & temp files =====================
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set undodir=~/.vim/undo


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup markdown_snippets
    autocmd!
    " Simple code block
    autocmd FileType markdown inoremap <buffer> cb ```<CR><CR>```<CR><Up><Up>
    " Shell code block
    autocmd FileType markdown inoremap <buffer> cbs ```sh<CR><CR>```<CR><Up><Up>
    " Python code block
    autocmd FileType markdown inoremap <buffer> cbp ```python<CR><CR>```<CR><Up><Up>
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ============================== FZF ==========================
map <leader>p :Files<CR>
map <leader>f :GFiles<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>T :Tags<CR>
nnoremap <leader>m :Marks<CR>

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
\   fzf#vim#with_preview(), <bang>0)


" ================== Rainbow Parentheses ====================
let g:rbpt_colorpairs = [
      \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_loadcmd_toggle = 0
" Rainbow Parentheses always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

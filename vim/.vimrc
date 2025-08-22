set number 		" Show the absolute line numbers
set relativenumber 	" Display relative line numbers
set clipboard=unnamed   " Global yanking with the OS's clipboard
set laststatus=2


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

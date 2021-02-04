" enable the syntax highlight 
syntax on

" enable the relative number on the left of each line
set number
set relativenumber

set tabstop=4
set autoindent

set shiftwidth=4

colorscheme default

autocmd FileType zsh setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s

nnoremap <Space> @

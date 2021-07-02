" Plugins
packadd commentary
" plugin tabmerge in .vim/plugin

" enable the relative number on the left of each line
set number
set relativenumber

" tab gestion 
set tabstop=4
set autoindent

set shiftwidth=4

" Colors 
syntax on 
packadd! onedark.vim
colorscheme onedark

" Commentary options
autocmd FileType zsh setlocal commentstring=#\ %s
autocmd FileType conf setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd FIleTYpe vim setlocal commentstring=\"\ %s

" split vindow option 
set splitright " new vertical splits are on the right
set splitbelow " new horizontal splits are on the bottom

nnoremap <Space> @

" macros 
let @b='a {}O	'
let @f='a\frac{}{}hhha'
let @o='oo'


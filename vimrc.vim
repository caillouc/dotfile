" Plugins
packadd commentary
packadd sleuth
" plugin tabmerge in .vim/plugin

" enable the relative number on the left of each line
set number
set relativenumber

" tab gestion 
set autoindent
" set tabstop=4
" set shiftwidth=4

set noshowmode

" Colors 
syntax on 
let g:one_allow_italics = 1
let g:onedark_terminal_italics = 1
packadd! onedark.vim
colorscheme onedark

set laststatus=2
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
packadd lightline.vim

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

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" macros
let @b='a {}ýaO'
let @f='a\frac{}{}hhha'
let @o='oo'


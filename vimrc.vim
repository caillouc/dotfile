" Plugins
packadd commentary
" packadd sleuth

" enable the relative number on the left of each line
set number
set relativenumber

" tab gestion 
set autoindent
set tabstop=4
set shiftwidth=4

set noshowmode

" Colors 
syntax on 
set termguicolors
set background=dark
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
packadd! gruvbox-material
colorscheme gruvbox-material

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox_material'

set laststatus=2
packadd lightline.vim

" Commentary options
autocmd FileType zsh setlocal commentstring=#\ %s
autocmd FileType conf setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd FIleTYpe vim setlocal commentstring=\"\ %s
autocmd FIleTYpe c setlocal commentstring=\/\/\ %s

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
let @b='a {}O'
let @f='a\frac{}{}hhha'
let @o='oo'
let @g='gg=G``'

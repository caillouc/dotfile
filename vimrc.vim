" Plugins
packadd commentary
packadd sleuth

" enable the relative number on the left of each line
set number
set relativenumber

" tab gestion 
set autoindent
set tabstop=4
set shiftwidth=4

set noshowmode

let mapleader = " "

" Colors 
syntax on 
set termguicolors
set background=dark
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_statusline_style = 'default'
" let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
packadd! gruvbox-material
colorscheme gruvbox-material

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox_material'

set laststatus=2
packadd lightline.vim

" Auto completion test
" filetype plugin on
" set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
" Remap enter, j and k to navigate in the menu
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> j pumvisible() ? "\<lt>Down>" : "j"
inoremap <expr> k pumvisible() ? "\<lt>Up>" : "k"
inoremap <expr> <C-p> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


" Commentary options
autocmd FileType zsh setlocal commentstring=#\ %s
autocmd FileType conf setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd FIleTYpe vim setlocal commentstring=\"\ %s
autocmd FIleTYpe c setlocal commentstring=\/\/\ %s
autocmd FIleTYpe java setlocal commentstring=\/\/\ %s

" File association
autocmd BufRead,BufNewFile *.sage set filetype=python

" remap crtl R to U
nnoremap U <C-r>

" split vindow option 
set splitright " new vertical splits are on the right
set splitbelow " new horizontal splits are on the bottom

nnoremap , @

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
tmap <silent> <c-k> :wincmd k<CR>
tmap <silent> <c-j> :wincmd j<CR>
tmap <silent> <c-h> :wincmd h<CR>
tmap <silent> <c-l> :wincmd l<CR>


" Terminal option
" Set term size
let termheight = 15
execute "set termwinsize =" . termheight . "*0"

" Execute a command in term
command -nargs=+ -complete=file TermOpenHidden call term_start("<args>", {"hidden":1, "term_finish":"open", "term_opencmd":"15split \| buffer %d"})
command -nargs=+ -complete=file TermOpen call term_start("<args>", {"term_finish":"open", "term_opencmd":"15split \| buffer %d"})
nnoremap <Leader>t :TermOpenHidden 
nnoremap <Leader>T :TermOpen 

" Restore a hidden term buffer
function! RestoreTerm()
	let buf = filter(map(getbufinfo(), 'v:val.bufnr'), 'getbufvar(v:val, "&buftype") is# "terminal"')
	execute "15sp | buffer " . buf[0]
endfunction
nnoremap <Leader>rt :call RestoreTerm()<CR>

tnoremap : <C-w>:

" Resize a split windows
nnoremap <Leader>p res +10<CR>
nnoremap <Leader>m :res -10<CR>
tnoremap <Leader>p <C-w>:res +10<CR>
tnoremap <Leader>m <C-w>:res -10<CR>
" move the windows (split) to a tab
nnoremap <Leader>n <C-w>T
tnoremap <Leader>n <C-w>T

" Indent whole file while preserving cursor location with <Leader>g
nnoremap <Leader>g m'gg=G`'

" Add a semicolon to the current line without moving the cursor with <Leader>;
nnoremap <Leader>; m'A;<ESC>`'

" Source vimrc with <Leader>vc
nnoremap <Leader>vc :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>

" Replace inner word in the entire file 
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap <Leader>o o<Esc>o
nnoremap <Leader>f a\frac{}{}<Esc>hhi
nnoremap <Leader>b a{<CR><BS>}<Esc>O

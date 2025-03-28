"   ---   General   ---   "

" tab gestion 
set autoindent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
xnoremap <Tab> >
xnoremap <S-Tab> <

set noshowmode
set hlsearch
set ignorecase

"   ---   Remap   ---   "
nnoremap ; :
nnoremap , @
nnoremap U <C-r>
" Double o
nnoremap <Leader>o o<Esc>o
" Go to previous cursor position
nnoremap <Leader>b <C-o>
" Format current paragraph
nnoremap <Leader>z gqip
" Toogle fold
nnoremap ff za

" Put the underliying word in lower/upper case
nnoremap <Leader>u guiw
nnoremap <Leader>U gUiw

" Use System Clipboard
" Use System Clipboard
if has('macunix')
	nnoremap <Leader>c "*yy
	xnoremap <Leader>c "*y
	nnoremap <Leader>v "*p
else 
	nnoremap <Leader>c "+yy
	xnoremap <Leader>c "+y
	nnoremap <Leader>v "+p
endif

" Add a semicolon to the current line without moving the cursor with <Leader>;
nnoremap <Leader>; m'A;<ESC>`'

" To move faster
nnoremap J 5j
nnoremap K 5k
xnoremap J 5j
xnoremap K 5k

" To move between split
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Replace inner word in the entire file 
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
xnoremap <Leader>r :s//g<Left><Left>

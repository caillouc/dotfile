"   ---   Plugins   ---   "
packadd commentary
" packadd sleuth





"   ---   General   ---   "
" Enable the relative number on the left of each line
set number
set relativenumber

" tab gestion 
set autoindent
set tabstop=4
set shiftwidth=4
set list
set listchars=tab:>-


" Formatting gestion
set formatlistpat=^\\s*                     " Optional leading whitespace
set formatlistpat+=[                        " Start character class
set formatlistpat+=\\[({]\\?                " |  Optionally match opening punctuation
set formatlistpat+=\\(                      " |  Start group
set formatlistpat+=[0-9]\\+                 " |  |  Numbers
set formatlistpat+=\\\|                     " |  |  or
set formatlistpat+=/[^a-zA-Z][a-zA-Z]/\\+   " |  |  Unique Letters
set formatlistpat+=\\)                      " |  End group
set formatlistpat+=[\\]:.)}                 " |  Closing punctuation
set formatlistpat+=]                        " End character class
set formatlistpat+=\\s\\+                   " One or more spaces
set formatlistpat+=\\\|                     " or
set formatlistpat+=^\\s*[-–+o*•]\\s\\+      " Bullet points
set formatoptions+=tcqn

set noshowmode

" split vindow option 
set splitright " new vertical splits are on the right
set splitbelow " new horizontal splits are on the bottom





"   ---   Remap   ---   "
let mapleader = " "
nnoremap , @
nnoremap U <C-r>
tnoremap : <C-w>:
nnoremap <Leader>o o<Esc>o
nnoremap <Leader>f a\frac{}{}<Esc>hhi
nnoremap <Leader>b a{<CR><BS>}<Esc>O

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
tmap <silent> <c-k> :wincmd k<CR>
tmap <silent> <c-j> :wincmd j<CR>
tmap <silent> <c-h> :wincmd h<CR>
tmap <silent> <c-l> :wincmd l<CR>

" Use System Clipboard
if has('macunix')
	nnoremap <Leader>c "*yy
	nnoremap <Leader>C "*p
else 
	nnoremap <Leader>c "+yy
	nnoremap <Leader>C "+p
endif

" Move the windows (split) to a tab
nnoremap <Leader>n <C-w>T
tnoremap <Leader>n <C-w>T

" Add a semicolon to the current line without moving the cursor with <Leader>;
nnoremap <Leader>; m'A;<ESC>`'

" Source vimrc with <Leader>vc
nnoremap <Leader>vc :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>

" Replace inner word in the entire file 
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left> 

" Remove all single trailing space of a file
nnoremap <Leader>a m':%s/\S\zs\s$//g<CR>`'





"   ---   Colors   ---   "
" Theme
syntax on 
set termguicolors
set background=dark
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_statusline_style = 'default'
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_enable_bold = 1
packadd! gruvbox-material
colorscheme gruvbox-material

" Status line
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox_material'
set laststatus=2
packadd lightline.vim





"   ---   Commentary options   ---   "
autocmd FileType zsh setlocal commentstring=#\ %s
autocmd FileType conf setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd FileType vim setlocal commentstring=\"\ %s
autocmd FileType c setlocal commentstring=\/\/\ %s
autocmd FileType java setlocal commentstring=\/\/\ %s
autocmd FileType tex setlocal commentstring=%\ %s
autocmd FileType yaml setlocal commentstring=#\ %s





"   ---   File association   ---   "
autocmd BufRead,BufNewFile *.sage set filetype=python
autocmd BufRead,BufNewFile *.cu set filetype=c





"   ---   Markdown config   ---   "
function! MathHighlight()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    " syn match math_block '\$[^$].\{-}\$'
    syn region math_block start=/\$[^$]/ end=/\$/

    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction
function! MarkdownConfig()
	call MathHighlight()
	setlocal textwidth=80
	" setlocal tabstop=2 shiftwidth=2 expandtab
	setlocal comments=    " to avoid some conflict while formating a list 
	syntax clear markdownCodeBlock " fix a conflict between codeBlock and list element
endfunction
autocmd FileType markdown call MarkdownConfig()





"   ---   Terminal option   ---   "
" Terminal size option
let termheight = 15
" let termwidth = 147 " size of mac display 
let termwidth = 227 " size of lg display
execute "set termwinsize =" . termheight . "x" . termwidth 

" Execute a command in term
command -nargs=+ -complete=file TermOpen botright terminal <args>
nnoremap <Leader>t :TermOpen 





"   ---   Make for each FileType   ---   "
autocmd FileType c nnoremap <Leader>e :TermOpen make <CR>
autocmd FileType python nnoremap <Leader>e :TermOpen python3 % <CR>
if has('macunix')
	autocmd FileType markdown nnoremap <Leader>e :TermOpen /Users/pierrecolson/Documents/prog/dotfile/gpdf.sh % <CR>
	autocmd FileType markdown nnoremap <Leader>E :TermOpen /Users/pierrecolson/Documents/prog/dotfile/gpdf.sh -no-toc % <CR>
else
	autocmd FileType markdown nnoremap <Leader>e :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh % <CR>
	autocmd FileType markdown nnoremap <Leader>E :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh -no-toc % <CR>
endif





"   ---   Coc config   ---   "
set encoding=utf-8

" TextEdit might fail if hidden is not set
set hidden	

" Aparently to avoid issue
set nobackup 
set nowritebackup

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Merge signcolumn and number column into one
set signcolumn=number

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate between diagnostics
nmap <silent> <leader>D <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :call CocAction('jumpDefinition') <CR>
nmap <silent> gi :call CocAction('jumpImplementation') <CR>
nmap <silent> gr :call CocAction('jumpReferences') <CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <leader>h :call CocActionAsync('highlight') <CR>

command! -nargs=0 Format :call CocAction('format')
" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>G  <Plug>(coc-format-selected)
nmap <leader>g :Format <CR>

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Shortcut to list and manage extensions
nnoremap <leader>l :CocList extensions <CR>

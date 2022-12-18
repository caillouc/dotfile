"   ---   Plugins   ---   "
packadd vim-commentary
packadd vim-surround
packadd copilot.vim
packadd coc.nvim




"   ---   General   ---   "
" Enable the relative number on the left of each line
set number
set relativenumber
set tabpagemax=100
set nofoldenable
set directory=.
nnoremap ; :

" tab gestion 
set autoindent
set tabstop=4
set shiftwidth=4
set list lcs=tab:>\ 

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
xnoremap <Tab> >
xnoremap <S-Tab> <
autocmd FileType scala,c,xml,l3,markdown,cpp  setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType rust  setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.gtm,*.dtm,*.stm setlocal tabstop=4 shiftwidth=4 expandtab

set noshowmode

" split vindow option 
set splitright " new vertical splits are on the right
set splitbelow " new horizontal splits are on the bottom

command Note :tabe ~/Desktop/note.md

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o





"   ---   Remap   ---   "
let mapleader = " "
nnoremap , @
nnoremap U <C-r>
tnoremap : <C-w>:
nnoremap <Leader>o o<Esc>o
nnoremap <Leader>b a{<CR>}<Esc>O

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
	xnoremap <Leader>c "*y
	nnoremap <Leader>v "*p
else 
	nnoremap <Leader>c "+yy
	xnoremap <Leader>c "+y
	nnoremap <Leader>v "+p
endif

" Move the windows (split) to a tab
nnoremap <Leader>n <C-w>T
tnoremap <Leader>n <C-w>T

" Add a semicolon to the current line without moving the cursor with <Leader>;
nnoremap <Leader>; m'A;<ESC>`'

" Source vimrc with <Leader>r
nnoremap <Leader>r :source ~/.vimrc<CR>:echo "Reloaded .vimrc"<CR>

" Replace inner word in the entire file 
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>s :s///g<Left><Left>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Remove all single trailing space of a file
nnoremap <Leader>a m':%s/\S\zs\s$//g<CR>`'

" Copilot
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
imap <C-P> <Plug>(copilot-suggest)
let g:copilot_no_tab_map = v:true





"   ---   Colors   ---   "
" Theme
syntax on 
set termguicolors
set background=dark
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_enable_bold = 1

let g:everforest_enable_italic = 1
let g:everforest_disable_italic_comment = 1
let g:everforest_enable_bold = 1

let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
let g:edge_enable_bold = 1

let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_enable_bold = 1

packadd! gruvbox-material
packadd! everforest
packadd! edge
packadd! sonokai

function! s:everforest_custom() abort
	let l:palette = everforest#get_palette('hard', {})
	call everforest#highlight('IncSearch', l:palette.none, l:palette.bg3, 'bold')
	call everforest#highlight('Search', l:palette.none, l:palette.bg3, 'bold')
	call everforest#highlight('MiniStatuslineModeReplace', l:palette.bg0, l:palette.bg3, 'bold')
endfunction
    
augroup EverforestCustom
	autocmd!
	autocmd ColorScheme everforest call s:everforest_custom()
augroup END

function! s:gruvbox_material_custom() abort
	let l:palette = gruvbox_material#get_palette('medium', 'material', {})
	call gruvbox_material#highlight('IncSearch', l:palette.none, l:palette.bg3, 'bold')
	call gruvbox_material#highlight('Search', l:palette.none, l:palette.bg3, 'bold')
	call gruvbox_material#highlight('MiniStatuslineModeReplace', l:palette.bg0, l:palette.bg3, 'bold')
endfunction
    
augroup GruvboxMaterialCustom autocmd!
	autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

function! s:edge_custom() abort
	let l:palette = edge#get_palette('aura', 0, {})
	call edge#highlight('IncSearch', l:palette.none, l:palette.bg3, 'bold')
	call edge#highlight('Search', l:palette.none, l:palette.bg3, 'bold')
	call edge#highlight('MiniStatuslineModeReplace', l:palette.bg0, l:palette.bg3, 'bold')
endfunction

augroup EdgeCustom
	autocmd!
	autocmd ColorScheme edge call s:edge_custom()
augroup END

function! s:sonokai_custom() abort
	let l:palette = sonokai#get_palette('atlantis', {})
	call sonokai#highlight('IncSearch', l:palette.none, l:palette.bg3, 'bold')
	call sonokai#highlight('Search', l:palette.none, l:palette.bg3, 'bold')
	call sonokai#highlight('MiniStatuslineModeReplace', l:palette.bg0, l:palette.bg3, 'bold')
endfunction

augroup SonokaiCustom
	autocmd!
	autocmd ColorScheme sonokai call s:sonokai_custom()
augroup END

let my_colorschemes = ['gruvbox-material', 'everforest' , 'edge', 'sonokai']
let index = rand() % (len(my_colorschemes))
echo my_colorschemes[index]
execute 'colorscheme' my_colorschemes[index]
let my_lightline_colorschemes = ['gruvbox_material', 'everforest' , 'edge', 'sonokai']

" Status line
let g:lightline = {}
let g:lightline.colorscheme = my_lightline_colorschemes[index]
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
autocmd FileType scala setlocal commentstring=\/\/\ %s
autocmd FileType tex setlocal commentstring=%\ %s
autocmd FileType yaml setlocal commentstring=#\ %s
autocmd FileType l3 setlocal commentstring=;;\ %s
autocmd FileType make setlocal commentstring=#\ %s
autocmd FileType vhdl setlocal commentstring=--\ %s
autocmd FileType ocaml setlocal commentstring=\/\/\ %s
autocmd FileType rust setlocal commentstring=\/\/\ %s





"   ---   File association   ---   "
autocmd BufRead,BufNewFile *.sage set filetype=python
autocmd BufRead,BufNewFile *.cu set filetype=c





"   ---   Fyle type config   ---   "
" Markdown
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
	setlocal comments=             " to avoid some conflict while formating a list 
	syntax clear markdownCodeBlock " fix a conflict between codeBlock and list element

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
	set formatoptions-=jrol
	set formatoptions+=tcqn
endfunction
autocmd FileType markdown call MarkdownConfig()





"   ---   Terminal option   ---   "
" Execute a command in term
command -nargs=+ -complete=file TermOpen split | resize 15 | terminal <args>
autocmd TermOpen * startinsert
tnoremap <ESC> <C-\><C-N>
nnoremap <Leader>t :TermOpen 





"   ---   Make for each FileType   ---   "
autocmd FileType c,make nnoremap <Leader>e :TermOpen make <CR>
autocmd FileType scala nnoremap <Leader>e :TermOpen ./bin/sbt compile <CR>
autocmd FileType scala nnoremap <Leader>E :TermOpen ./bin/sbt test <CR>
autocmd FileType java nnoremap <Leader>e :TermOpen mvn package <CR>
autocmd FileType rust nnoremap <Leader>e :TermOpen cargo run <CR>
function! PythonMake()
	if winheight(0) + &cmdheight + 1 != &lines
		" There is a horizontal split window so I close it 
		" Horizontal split are only for terminal output in my use
		wincmd j
		execute "normal! :q! \<CR> :TermOpen python3 % \<CR>"
	else 
		execute "normal! :TermOpen python3 % \<CR>"
	endif
endfunction
autocmd FileType python nnoremap <Leader>e :call PythonMake()<CR>
if has('macunix')
	autocmd FileType markdown nnoremap <Leader>e :TermOpen /Users/pierrecolson/Documents/prog/dotfile/gpdf.sh % <CR>
	autocmd FileType markdown nnoremap <Leader>E :TermOpen /Users/pierrecolson/Documents/prog/dotfile/gpdf.sh -no-toc % <CR>
	autocmd FileType markdown nnoremap <Leader>h :TermOpen /Users/pierrecolson/Documents/prog/dotfile/gpdf.sh -html % <CR>
else
	autocmd FileType markdown nnoremap <Leader>e :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh % <CR>
	autocmd FileType markdown nnoremap <Leader>E :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh -no-toc % <CR>
	autocmd FileType markdown nnoremap <Leader>h :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh -html % <CR>
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
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Navigate between diagnostics
nmap <silent> <leader>D <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :call CocAction('jumpDefinition') <CR>
nmap <silent> gi :call CocAction('jumpImplementation') <CR>
nmap <silent> gr :call CocAction('jumpReferences') <CR>

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" nnoremap <leader>h :call CocActionAsync('highlight') <CR>

command! -nargs=0 Format :call CocAction('format')
" Formatting selected code.
nmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>f :Format <CR>

" Shortcut to list and manage extensions
nnoremap <leader>l :CocList extensions <CR>

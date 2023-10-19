"   ---   Plugins   ---   "
call plug#begin(stdpath('config').'/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'
Plug 'github/copilot.vim'
call plug#end()
let g:livepreview_previewer = 'open -a Preview'





"   ---   General   ---   "
set number
" set relativenumber
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
autocmd FileType scala,c,xml,l3,markdown,cpp,dart,html  setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType rust  setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.gtm,*.dtm,*.stm setlocal tabstop=4 shiftwidth=4 expandtab

set noshowmode
set hlsearch
set ignorecase

command Note :edit ~/Desktop/note.md
if has('macunix')
	command Vimrc :edit ~/Documents/dotfile/vimrc.vim
else
	command Vimrc :edit ~/Documents/prog/dotfile/vimrc.vim
endif

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fold option
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
autocmd BufReadPost,FileReadPost * normal zR

" Disable mouse support
set mouse=




"   ---   Remap   ---   "
let mapleader = " "
nnoremap , @
nnoremap U <C-r>
nnoremap <Leader>o o<Esc>o
" Go to previous buffer
nnoremap <Leader>b <C-6>
" Format current paragraph
nnoremap <Leader>g gqip
" Quit and save
nnoremap <Leader>Q :wq<CR>
" Save the file
nnoremap <Leader>w :w<CR>

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

" Replace inner word in the entire file 
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>r :s///g<Left><Left>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Remove all single trailing space of a file
nnoremap <Leader>A m':%s/\S\zs\s$//g<CR>`'





"   ---   Split option   ---   "
" Use ctrl-[hjkl] to select the active split!
nmap <silent> K :wincmd k<CR>
nmap <silent> J :wincmd j<CR>
nmap <silent> H :wincmd h<CR>
nmap <silent> L :wincmd l<CR>
tmap <silent> K :wincmd k<CR>
tmap <silent> J :wincmd j<CR>
tmap <silent> H :wincmd h<CR>
tmap <silent> L :wincmd l<CR>

set splitright " new vertical splits are on the right
set splitbelow " new horizontal splits are on the bottom

nnoremap <Leader>s :vert sb 

" Get back to previous split
nnoremap <silent> <Leader>j <C-w>w
" Swap the two split
nnoremap <silent> <Leader>J <C-w>r
" Resize option
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
" nnoremap <silent> <Leader>- :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <silent> <Leader>= <C-w>=<CR>






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

function! s:link_highlight() abort
	highlight! link IncSearch Visual
	highlight! link Search Visual
	highlight! link Substitute Visual
endfunction

function! s:everforest_custom() abort
	call s:link_highlight()
	let l:palette = everforest#get_palette('hard', {})
endfunction
    
augroup EverforestCustom
	autocmd!
	autocmd ColorScheme everforest call s:everforest_custom()
augroup END

function! s:gruvbox_material_custom() abort
	call s:link_highlight()
	let l:palette = gruvbox_material#get_palette('medium', 'material', {})
endfunction
    
augroup GruvboxMaterialCustom autocmd!
	autocmd ColorScheme gruvbox-material call s:gruvbox_material_custom()
augroup END

function! s:edge_custom() abort
	call s:link_highlight()
	let l:palette = edge#get_palette('aura', 0, {})
endfunction

augroup EdgeCustom
	autocmd!
	autocmd ColorScheme edge call s:edge_custom()
augroup END

function! s:sonokai_custom() abort
	call s:link_highlight()
	let l:palette = sonokai#get_palette('atlantis', {})
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





"   ---   Plugin options   ---   "
let g:plug_window = 'vertical new'

" Copilot
" imap <silent><script><expr> <leader>j copilot#Accept("\<CR>")
" let g:copilot_no_tab_map = v:true
imap <C-P> <Plug>(copilot-suggest)

" Markdown-preview
let g:mkdp_auto_close = 0
let g:mkdp_theme = 'light'
autocmd FileType markdown nmap <Leader>p <Plug>MarkdownPreviewToggle

" Lightline
set laststatus=2
let g:lightline = {
	\ 'enable': { 'tabline': 0 },
	\ 'colorscheme': my_lightline_colorschemes[index]
	\ }

" Bufferline
lua << EOF
require("bufferline").setup{
	options = {
		separator_style = "slant",
		diagnostics = "coc",
		show_buffer_close_icons = false,
		modified_icon = '*',
		numbers = function(opts)
			return string.format('%s.%s', opts.ordinal, opts.lower(opts.id))
		end,
		style_preset = require('bufferline').style_preset.no_bold,
		offsets = {{
			filetype = "nerdtree",
			text = "File Explorer",
			highlight = "Directory",
			text_align = "center",
			separator = true
		}},
		hover = {
			enable = false
		},
	},
}
EOF
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
" nnoremap <silent><leader>$ <Cmd>BufferLineGoToBuffer -1<CR>
nnoremap <silent>gt :BufferLineCycleNext<CR>
nnoremap <silent>gT :BufferLineCyclePrev<CR>

" FZF
nnoremap <silent><leader>z :Files<CR>
nnoremap <Leader>Z :Rg <C-r><C-w><CR>





"   ---   Commentary options   ---   "
autocmd FileType zsh setlocal commentstring=#\ %s
autocmd FileType conf setlocal commentstring=#\ %s
autocmd FileType sh setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd FileType nvim setlocal commentstring=\"\ %s
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
autocmd FileType dart setlocal commentstring=\/\/\ %s





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
tnoremap : <C-w>:
" Execute a command in term
command -nargs=+ -complete=file TermOpen botright split | resize 15 | terminal <args>
autocmd TermOpen * startinsert
command TermClose bufdo if stridx(bufname(), 'term://') >= 0 | bdelete! | endif
tnoremap <ESC> <C-\><C-N>
" nnoremap <Leader>t :TermClose<CR> <bar> :TermOpen 
nnoremap <Leader>t :TermOpen 
nnoremap <Leader>T :TermClose<CR>





"   ---   Make for each FileType   ---   "
autocmd FileType c,make nnoremap <Leader>m :TermOpen make <CR>
autocmd FileType scala nnoremap <Leader>m :TermOpen ./bin/sbt compile <CR>
autocmd FileType scala nnoremap <Leader>M :TermOpen ./bin/sbt test <CR>
autocmd FileType java nnoremap <Leader>m :TermOpen mvn package <CR>
autocmd FileType rust nnoremap <Leader>m :TermOpen cargo run <CR>
autocmd FileType python nnoremap <Leader>m :TermOpen python3 % <CR>
autocmd BufRead vimrc.vim nnoremap <Leader>m :source /Users/pierrecolson/.config/nvim/init.vim<CR>





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
inoremap <silent><expr> <c-space> coc#refresh()

" Navigate between diagnostics
nmap <silent> <leader>D <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd :call CocAction('jumpDefinition') <CR>
nmap <silent> gi :call CocAction('jumpImplementation') <CR>
" nmap <silent> gr :call CocAction('jumpReferences') <CR>

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" nnoremap <leader>h :call CocActionAsync('highlight') <CR>

command! -nargs=0 Format :call CocAction('format')
" Formatting selected code.
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f :Format <CR>

" Shortcut to list and manage extensions
nnoremap <leader>L :CocList extensions <CR>





"   ---   Treesitter config   ---   "
lua << EOF
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = {"vim", "python" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	indent = {
		enable = false
	},

	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	}
}
EOF

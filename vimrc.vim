"   ---   Plugins   ---   "
call plug#begin(stdpath('config').'/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown'}

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }

Plug 'itchyny/lightline.vim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'

Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'

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
autocmd FileType scala,c,xml,l3,markdown,cpp,dart,html,css,scss  setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType rust  setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufRead,BufNewFile *.gtm,*.dtm,*.stm setlocal tabstop=4 shiftwidth=4 expandtab

set noshowmode
set hlsearch
set ignorecase

command Note :edit ~/Desktop/note.md
command Vimrc :edit ~/Documents/dotfile/vimrc.vim


autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Fold option
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
nmap fc zc
nmap fo zo
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
nnoremap <Leader>z gqip
" Quit and save
nnoremap <Leader>Q :wq<CR>
" Save the file
nnoremap <Leader>w :w<CR>
" clear highlight
nnoremap <Leader>h :noh<CR>

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

" Remove all single trailing space of a file
nnoremap <Leader>A m':%s/\S\zs\s$//g<CR>`'





"   ---   Split option   ---   "
" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> K :wincmd k<CR>
nnoremap <silent> J :wincmd j<CR>
nnoremap <silent> H :wincmd h<CR>
nnoremap <silent> L :wincmd l<CR>
tnoremap <silent> K :wincmd k<CR>
tnoremap <silent> J :wincmd j<CR>
tnoremap <silent> H :wincmd h<CR>
tnoremap <silent> L :wincmd l<CR>

set splitright " new vertical splits are on the right
set splitbelow " new horizontal splits are on the bottom

nnoremap <Leader>s :vert sb 

" Get back to previous split
nnoremap <silent> <Leader>j <C-w>p
" Swap the two split
nnoremap <silent> <Leader>J <C-w>r
" Resize option
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
nnoremap <silent> <Leader>= <C-w>=<CR>






"   ---   Colors   ---   "
" Theme
syntax on 
set termguicolors
set background=dark
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_enable_bold = 1
let g:sonokai_style = 'atlantis'

function! s:sonokai_custom() abort
	highlight! link TSParameter Orange
	" highlight! link IncSearch Visual
	" highlight! link Search Visual
	" highlight! link Substitute Visual
	let l:palette = sonokai#get_palette('atlantis', {})
	call sonokai#highlight('IncSearch', l:palette.none, l:palette.bg_red)
	call sonokai#highlight('Search', l:palette.none, l:palette.diff_red)
	call sonokai#highlight('Substitute', l:palette.none, l:palette.grey_dim)
endfunction

augroup SonokaiCustom
	autocmd!
	autocmd ColorScheme sonokai call s:sonokai_custom()
augroup END

colorscheme sonokai





"   ---   Plugin options   ---   "
let g:plug_window = 'vertical new'

" Copilot
imap <C-j> <Plug>(copilot-suggest)
imap <C-J> <Plug>(copilot-dismiss)
let g:copilot_filetypes = {
	\ 'text': v:false,
	\ 'markdown': v:false,
\ }

" Markdown-preview
let g:mkdp_auto_close = 0
let g:mkdp_theme = 'light'
autocmd FileType markdown nmap <Leader>p <Plug>MarkdownPreviewToggle

" Lightline
set laststatus=2
let g:lightline = {
	\ 'enable': { 'tabline': 0 },
	\ 'colorscheme': 'sonokai',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'gitbranch' ], 
	\             [ 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'FugitiveHead'
	\ },
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
		hover = {
			enable = false
		},
		custom_filter = function(buf_number, buf_numbers)
			-- filter out Termanal buffer from the bufferline
			return not vim.fn.bufname(buf_number):match('term://')
		end,
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
nnoremap <silent>gt :BufferLineCycleNext<CR>
nnoremap <silent>gT :BufferLineCyclePrev<CR>

" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>f  <cmd>Telescope find_files<cr>
nnoremap <leader>F  <cmd>Telescope find_files hidden=true
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>G <cmd>Telescope grep_string<cr>
nnoremap <leader>n <cmd>Telescope registers<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>





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
" Function to close all terminal
fun! TermClose()
	if stridx(bufname(), 'term://') >= 0
		wincmd p
	endif
	" let currBuff=bufnr("%")
	" execute "bufdo if stridx(bufname(), 'term://') >= 0 | bdelete! | endif"
	" execute 'buffer ' . currBuff
	let buffers = filter(range(1, bufnr('$')), "stridx(bufname(v:val), 'term://') >= 0")
	if empty(buffers)
		echo "No terminal buffer found"
		return
	endif
	exe 'bd '.join(buffers, ' ')
	if len(buffers) == 1
		echo "1 terminal buffer has been closed"
	else 
		echo len(buffers)." terminal buffers have been closed"
	endif
endfunction
command TermClose call TermClose()
" Execute a command in term
command -nargs=+ -complete=file TermOpen call TermClose() | botright split | resize 15 | terminal <args>
autocmd TermOpen * startinsert
tnoremap <ESC> <C-\><C-N>
nnoremap <Leader>t :TermOpen 
" nnoremap <Leader>t :TermOpen 
nnoremap <Leader>T :TermClose<CR>





"   ---   Make for each FileType   ---   "
autocmd FileType c,make nnoremap <Leader>m :TermOpen make <CR>
autocmd FileType scala nnoremap <Leader>m :TermOpen ./bin/sbt compile <CR>
autocmd FileType scala nnoremap <Leader>M :TermOpen ./bin/sbt test <CR>
autocmd FileType java nnoremap <Leader>m :TermOpen mvn package <CR>
autocmd FileType rust nnoremap <Leader>m :TermOpen cargo run <CR>
autocmd FileType python nnoremap <Leader>m :TermOpen python3 % <CR>
autocmd FileType dart nnoremap <Leader>m :TermOpen flutter run<CR>
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
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader>H :call ShowDocumentation()<CR>
" Show hover when provider exists, fallback to vim's builtin behavior.
function! ShowDocumentation()
if CocAction('hasProvider', 'hover')
  call CocActionAsync('definitionHover')
endif
endfunction


command! -nargs=0 Format :call CocAction('format')
" Formatting selected code.
vmap <leader>e  <Plug>(coc-format-selected)
nmap <leader>e :Format <CR>

" Shortcut to list and manage extensions
nnoremap <leader>L :CocList extensions <CR>





"   ---   Treesitter config   ---   "
lua << EOF
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = {"vim", "python", "java", "lua"},

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


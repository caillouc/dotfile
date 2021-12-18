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

" File specific config 
autocmd BufRead,BufNewFile *.md setlocal textwidth=100

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
" command -nargs=+ -complete=file TermOpenHidden call term_start("<args>", {"hidden":1, "term_finish":"open", "term_opencmd":"botright 15split \| buffer %d"})
command -nargs=+ -complete=file TermOpen botright terminal <args>
" nnoremap <Leader>T :TermOpenHidden 
nnoremap <Leader>t :TermOpen 

" Automatically execute the file depending on his type
autocmd FileType c nnoremap <Leader>e :TermOpen make <CR>
autocmd FileType python nnoremap <Leader>e :TermOpen python3 % <CR>
autocmd FileType markdown nnoremap <Leader>e :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh % <CR>
autocmd FileType markdown nnoremap <Leader>E :TermOpen /home/pierre/Documents/prog/dotfile/gpdf.sh -no-toc % <CR>

" Restore a hidden term buffer
" function! RestoreTerm()
"     let buf = filter(map(getbufinfo(), 'v:val.bufnr'), 'getbufvar(v:val, "&buftype") is# "terminal"')
"     execute "15sp | buffer " . buf[0]
" endfunction
" nnoremap <Leader>rt :call RestoreTerm()<CR>

tnoremap : <C-w>:

" Resize a split windows
nnoremap <Leader>p :res +10<CR>
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



" coc configuration 
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
nmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>f :Format <CR>

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

nnoremap <silent><nowait> <leader>a  :<C-u>CocList diagnostics<cr>

" function! CocCurrentFunction()
"     return get(b:, 'coc_current_function', '')
" endfunction


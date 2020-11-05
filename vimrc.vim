" enable the syntax highlight 
syntax on

" enable the relative number on the left of each line
set number
set relativenumber

set tabstop=4
set autoindent

" function that use python to generate a random value between 1 and 2
function! Random() 
python << pythonFunc
import vim
import random 
i = random.randint(1, 3)
vim.command("let rand = '%d'"% i)
pythonFunc
return rand
endfunction 

" depending on a random value change the colorscheme
let rand = Random()

if rand==1 
	colorscheme delek
else 
	colorscheme default
endif

" much more color scheme in ~/.vim/colors

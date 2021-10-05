source /home/pierre/Documents/prog/zsh_file/own_command.zsh
source /home/pierre/Documents/prog/zsh_file/path.zsh

autoload -U colors && colors
source $ZSH_PLUGIN_PATH/git.zsh

# zsh constant
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"   

# Theme for the terminal
source $DOTFILE_PATH/nice.zsh-theme

. /usr/share/autojump/autojump.sh
source $JUMP_CMD_PATH/cmds.sh

# shortcut 
# alias ls='lj --color'                           # Use lj by default instead of ls (https://github.com/caillouc/jump-commands)
alias ls='ls --color'                           # Make ls colorfull
alias vim='vim -p'                              # Use -p option with vim by default
alias please='sudo'                             # Be polite with your computer
alias py='python3'                              # Open a python shell
alias la='ls -liah'                             # Better version of ls
alias zshrc="vim $HOME/.zshrc"                  # Edit .zsshrc file
alias path='echo $PATH'                         # Display the path variable 	
alias c='cd && clear && neofetch'               # Clear the terminal and run neofetch
alias aj='autojump'                             # Because autojump is too long
alias vimrc="vim $DOTFILE_PATH/vimrc.vim"       # Edit vimrc file
alias profile="vim $DOTFILE_PATH/profile.zsh"   # Edit profile.zsh file
alias sprofile="source $HOME/.zshrc"            # Source this file

# Move to trash a file 
sp () {
	{ 
		yes | mv "$@" ~/.Trash > /dev/null 2>&1 ;
	} || {
		mv "$@" "_$@" && sp "_$@" ;
	}
}

# quit way to take some note 
alias note="vim ~/Desktop/note.md"

# now cd execute ls builtin when arrive in destinaion and add shortcut
cd () {
	case $1 in 
		"") builtin cd $HOME && ls .         ;;
		*) builtin cd "$1" && ls .         	 ;;
	esac
}

# cd shortcut 
alias cd..='cd ../'                         # Go back 1 directory level(for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias 3.='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias 4.='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias 5.='cd ../../../../../'               # Go back 5 directory levels
alias 6.='cd ../../../../../../'            # Go back 6 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

# easy ps aux with grep command
pg (){
	ps aux | grep $1
}

# easy ls with grep command
lg () {
	WORD=${@: -1}
	DEST=( "$@" )
	unset "DEST[${#array[@]}-1]"
	ls $DEST | grep $WORD
}

# easy ls -lia with grep command
lag () {
	WORD=${@: -1}
	DEST=( "$@" )
	unset "DEST[${#array[@]}-1]"
	la $DEST | grep $WORD
}

# extract method
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1     ;;
			*.tar.gz)    tar xzf $1     ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar e $1     ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xf $1      ;;
			*.tbz2)      tar xjf $1     ;;
			*.tgz)       tar xzf $1     ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)           echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# markdown shortcut 
mkd () {
	touch "$1.md"
	DATE="`date "+%A %d %B"`"
	echo "---\ntitle: $1\nauthor: Pierre Colson\ndate: $DATE\n---" > "$1.md"
	vim "$1.md"
}

gpdf () {
	if [ $1 = "-no-toc" ] ; then 
		filename="${2%%.*}"
		command="pandoc $2 -f markdown+tex_math_single_backslash -o $filename.pdf --highlight-style=tango --natbib --pdf-engine=pdflatex && open $filename.pdf &"
		eval $command
	else 
		filename="${1%.*}"
		command="pandoc $1 -f markdown+tex_math_single_backslash -o $filename.pdf --toc --toc-depth=3 --highlight-style=tango --natbib --pdf-engine=pdflatex && open $filename.pdf &"
		eval $command
	fi
}

# shortcut git 
gcp () { git add -A && git commit -m "$@" && git push; }

alias grh='git reset --hard'
alias poussin='git pull'

# zsh plugin 
source $ZSH_PLUGIN_PATH/please.plugin.zsh
source $ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGIN_PATH/zsh-you-should-use/you-should-use.plugin.zsh

# password manager shortcut
source $PASSWORD_MANAGER_PATH/p_command

# file encoder shortcut
# see on https://github.com/caillouc/fileEncoder
encode(){
	if [ -z "$1" ]; then
		echo "invalid argument"
	else
		python3 $ENCODER_PATH/encoder.py encode $1
	fi
}

decode(){
	if [ -z "$1" ]; then
		echo "invalid argument"
	else
		python3 $ENCODER_PATH/encoder.py decode "$1"
	fi
}

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

export FUNCNEST=1000

alias pi='ssh pi@192.168.1.30'
alias iconf="vim $HOME/.config/i3/config"

neofetch


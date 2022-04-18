autoload -U colors && colors
source $ZSH_PLUGIN_PATH/git.zsh

# zsh constant
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"   

# Theme for the terminal
source $DOTFILE_PATH/nice.zsh-theme

source $JUMP_CMD_PATH/cmds.sh

# shortcut 
# alias ls='lj --color'                         # Use lj by default instead of ls (https://github.com/caillouc/jump-commands)
alias ls='ls --color'
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
alias jd="j drive"                              # shortcut that jump to the base directory of my drive (gitdrive)
alias iconf="vim $HOME/.config/i3/config"       # Quickly edit i3 config file

# enable vim in terminal command
# bindkey -v

# Move to trash a file or a directory
sp () {
	mv --backup=numbered "$@" ~/.Trash 
}

# quick way to take some note 
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
			*.tar.xz)    tar xf $1      ;;
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
	DATE="`date "+%A %d %B %Y"`"
	echo "---\ntitle: $1\nauthor: Pierre Colson\ndate: $DATE\n---" > "$1.md"
	vim "$1.md"
}

# generate pdf from markwon
gpdf () {
	$DOTFILE_PATH/gpdf.sh "$@" 
}

# shortcut git 
gcp () { git add -A && git commit -m "$@" && git push; }
alias grh='git reset --hard'
alias poussin='git pull --rebase'

# zsh plugin 
source $ZSH_PLUGIN_PATH/please.plugin.zsh
source $ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGIN_PATH/zsh-you-should-use/you-should-use.plugin.zsh

# password manager shortcut
source $PASSWORD_MANAGER_PATH/p_command
export PASSWORD_STORE_DIR="$DRIVE_PATH/.password-store"

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

# Because it's cool
neofetch

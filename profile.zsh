autoload -U colors && colors
autoload -U compinit; compinit

# zsh constant
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"   

# History file for zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# Share history in every terminal session
setopt SHARE_HISTORY


# Theme for the terminal
source $DOTFILE_PATH/nice.zsh-theme

source $JUMP_CMD_PATH/cmds.sh

# shortcut 
alias ls='ls --color'
alias vim='nvim'                               # Use -p option with nvim by default
alias please='sudo'                             # Be polite with your computer
alias py='python3'                              # Open a python shell
alias la='ls -liah'                             # Better version of ls
alias zshrc="nvim $HOME/.zshrc"                 # Edit .zsshrc file
alias path='echo $PATH'                         # Display the path variable 	
alias c='cd && clear && neofetch'               # Clear the terminal and run neofetch
alias aj='autojump'                             # Because autojump is too long
alias vimrc="nvim $DOTFILE_PATH/vimrc.vim"      # Edit vimrc file
alias profile="nvim $DOTFILE_PATH/profile.zsh"  # Edit profile.zsh file
alias sprofile="source $HOME/.zshrc"            # Source this file
alias iconf="nvim $HOME/.config/i3/config"      # Quickly edit i3 config file

export EDITOR="/usr/bin/nvim"
alias pi="TERM=xterm-256color ssh pierre@192.168.1.30"  # Connect to the raspberry pi

# enable nvim in terminal command
# bindkey -v

# Move to trash a file or a directory
sp () {
	mv --backup=numbered -f "$@" ~/.Trash 
}

# quick way to take some note 
alias note="nvim ~/Desktop/note.md"

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
	nvim "$1.md"
}

# generate pdf from markwon
gpdf () {
	$DOTFILE_PATH/gpdf.sh "$@" 
}

# shortcut git 
gcp () { git add -A && git commit -m "$@" && git push; }
RED='\033[0;31m'
NC='\033[0m' # No Color
alias grh="echo -e '${RED}Never again !!${NC}'" # Used to be alias for git reset --hard
alias poussin='git pull --rebase'

# zsh plugin 
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#928374"
source $ZSH_PLUGIN_PATH/please.plugin.zsh
source $ZSH_PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[Z' autosuggest-accept

# password manager shortcut
export PASSWORD_STORE_DIR="$DOC_PATH/.password-store"
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_GENERATED_LENGTH=20

# Because it's cool
neofetch

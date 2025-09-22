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
source $DOTFILE_PATH/terminal/nice.zsh-theme

source $JUMP_CMD_PATH/cmds.sh

# shortcut 
alias ls="ls --color"                                           # Display color with ls (for ssh connction)
alias vim='nvim'                                                # Use -p option with nvim by default
alias please='/usr/bin/sudo'                                    # Be polite with your computer
alias py='python3'                                              # Open a python shell
alias la='ls -liah'                                             # Better version of ls
alias zshrc="nvim $HOME/.zshrc"                                 # Edit .zsshrc file
alias path='echo $PATH'                                         # Display the path variable 	
alias aj='autojump'                                             # Because autojump is too long
alias vimrc="nvim $DOTFILE_PATH/vimrc.vim"                      # Edit vimrc file
alias profile="nvim $DOTFILE_PATH/terminal/profile.zsh"         # Edit profile.zsh file
alias sprofile="source $HOME/.zshrc"                            # Source this file
alias hconf="nvim $DOTFILE_PATH/linux/hyprland.conf"            # Quickly edit i3 config file
alias n="nautilus ."                                            # Open file manager to the current location
alias open="xdg-open"                                           # Open file
alias copy="wl-copy"                                            # Because I cannot remember the command every time I need it
alias paste="wl-paste"                                          # Same reason

export EDITOR="/usr/bin/nvim"
alias magenta="TERM=xterm-256color ssh pierre@magenta.clsn.fr"  # Connect to the magenta

alias gpu-driver="lspci -n -n -k | grep -A 2 -e VGA -e 3D && modinfo -F version nvidia"

# Move to trash a file or a directory
sp () {
	mv --backup=numbered -f "$@" ~/.local/share/Trash/files
}

# quick way to take some note 
alias note="nvim ~/Desktop/note.md"

# now cd execute ls builtin when arrive in destinaion
cd () {
	case $1 in 
		"") builtin cd $HOME && ls .         ;;
		*) builtin cd "$1" && ls .         	 ;;
	esac
}

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
gcp () { git add -u && gitmoji -c --title="$@" && git push; }

RED='\033[0;31m'
NC='\033[0m' # No Color
alias grh="echo -e '${RED}Never again !!${NC}'" # Used to be alias for git reset --hard
alias poussin='git pull'



# zsh plugin 
ZVM_ESCAPE_KEYTIMEOUT=0
source $ZSH_PLUGIN_PATH/please.plugin.zsh
source $ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Define a function to set the keybinding after everything loads
setup_autosuggest_bindings() {
  # Only bind if the widget is available
  if zle -l | grep -q autosuggest-accept; then
    bindkey '^[[Z' autosuggest-accept
    # Remove the hook after binding to prevent repeated execution
    unset -f setup_autosuggest_bindings
  fi
}

# Attach to precmd hook (runs just before each prompt display)
autoload -Uz add-zsh-hook
add-zsh-hook precmd setup_autosuggest_bindings

fastfetch

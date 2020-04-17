source ~/caillou/prog/privateDotfile/own_command.zsh

# zsh constant
export BASH_SILENCE_DEPRECATION_WARNING=1
ZSH_THEME="nice"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"   

# shortcut 
alias py='python3'                              # Open a python shell
alias rf='rf -rf'                               # Shortcut for delete folder
alias off='sudo shutdown -h now'                # Turn off the computer 
alias safari='open -a Safari'                   # Open safari
alias messages='open -a Messages'               # Open messages
alias f='open -a Finder ./'                     # Open the current directory in finder
alias la='ls -la'                               # Better version of ls
alias zshrc="vim $HOME/.zshrc"                  # Edit .zsshrc file
alias path='echo $PATH'                         # Display the path variable 	
alias v='vim'                                   # Vim command 
alias c='clear'                                 # Clear the terminal
alias o='open'                                  # open command  
alias updatedb='sudo /usr/libexec/locate.updatedb'      # udatedb for locate command 
alias sprofile="source $HOME/.zshrc"                    # Source this file

sp () {
	{ 
		yes | mv "$@" ~/.Trash > /dev/null 2>&1 ;
	} || {
		mv "$@" "_$@" && sp "_$@" ;
	}
}

# pdf generator from md file using pandoc 
gpdf  () {
	EXTENSION="`echo $1| cut -d'.' -f 2`"
	FILE_NAME="`echo $1| cut -d'.' -f 1`"
	if [ $EXTENSION = "md" ]; then 
		pandoc "$1" -o "$FILE_NAME.pdf"
	else 
		echo 'Manvaise extension ... required .md and not .'$EXTENSION''
	fi
}

# display or not the hidden file in finder 
alias hidefile='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias showfile='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'	

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
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

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

# shortcut git 
gcp () { git add -A && git commit -m "$@" && git push; }

alias status='git status'
alias branch='git branch'
alias grh='git reset --hard'

# color for the terminal 
export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad
#export PS1="\u: \w $ "
#export PS1="\[\033[1;32m\]\u: \[\033[1;34m\]\w $ \[\033[0m\]"

# set defautl version of java
#export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"  use for sbt
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home"	# use for javafx
export PATH="$JAVA_HOME/bin:$PATH"

# plugin zsh 
plugins=(
	zsh-autosuggestions
	osx
	autojump
	sudo
)
# can add git plugin

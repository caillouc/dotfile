source ~/caillou/prog/privateDotfile/path.zsh
source ~/caillou/prog/privateDotfile/own_command.zsh

source $ZSH_PLUGIN_PATH/git.zsh
autoload -U colors && colors

# zsh constant
export BASH_SILENCE_DEPRECATION_WARNING=1
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"   

# Theme for the terminal
source $DOTFILE_PATH/nice.zsh-theme

# shortcut 
alias please='sudo'                             # Be polite with your computer
alias py='python3'                              # Open a python shell
alias rf='rf -rf'                               # Shortcut for delete folder
alias off='sudo shutdown -h now'                # Turn off the computer 
alias safari='open -a Safari'                   # Open safari
alias messages='open -a Messages'               # Open messages
alias f='open -a Finder ./'                     # Open the current directory in finder
alias la='/bin/ls -la'                          # Better version of ls
alias zshrc="vim $HOME/.zshrc"                  # Edit .zsshrc file
alias path='echo $PATH'                         # Display the path variable 	
alias v='vim'                                   # Vim command 
alias c='clear && neofetch'                     # Clear the terminal and run neofetch
alias o='open'                                  # Open command  
alias aj='autojump'                             # Because autojump is too long
alias profile="vim $PROFILE_PATH"               # Edit profile.zsh file
alias cprofile="code $PROFILE_PATH"             # Edit profile file with vscode
alias ide='sbt launchIDE'                       # shortcut for sbt
alias updatedb='sudo /usr/libexec/locate.updatedb'      # udatedb for locate command 
alias sprofile="source $HOME/.zshrc"                    # Source this file

# Move to trash a file 
sp () {
	{ 
		yes | mv "$@" ~/.Trash > /dev/null 2>&1 ;
	} || {
		mv "$@" "_$@" && sp "_$@" ;
	}
}

# display or not the hidden file in finder 
alias hidefile='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias showfile='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'	

# quit way to take some note 
alias note="vim ~/Desktop/note.txt"

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

# mv command unsing autojump 
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
jmv () {	
	#FILE=${@: -2}
	#FILE="`echo $FILE | head -n1 | cut -d " " -f1`"
	DEST=${@: -1}
	FILE=( "$@" )
	unset "FILE[${#array[@]}-1]"
	if [ -d "$DEST" ]; then
		mv -f $FILE $DEST
		cd $DEST
	else 
		NEWDEST="`autojump $DEST`"
		if [ ! "$NEWDEST" = "." ]; then 
			if [ -t 1 ]; then  # if stdout is a terminal, use colors
                echo -e "\\033[31mmv -f ${FILE} ${NEWDEST}\\033[0m"
        	else
                echo -e "mv -f ${FILE} ${NEWDEST}"
			fi
			mv -f $FILE $NEWDEST
			cd $NEWDEST
		fi
	fi
}

# ls command using autojump
ls () {
	DESTINATION=$1
	if [ $# -eq 0 ]; then
		/bin/ls
	elif [ -d "$DESTINATION" ]; then
		/bin/ls $DESTINATION
	else 
		NEWDESTINATION="`autojump $DESTINATION`"
		if [ ! "$NEWDESTINATION" = "." ]; then 
			if [ -t 1 ]; then  # if stdout is a terminal, use colors
                echo -e "\\033[31mls ${NEWDESTINATION}\\033[0m"
        	else
                echo -e "ls ${NEWDESTINATION}"
			fi
			/bin/ls $NEWDESTINATION
		fi 
	fi
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
	filename="${1%.*}"
	command="pandoc $1 -f markdown+tex_math_single_backslash -o $filename.pdf --toc --toc-depth=2 --highlight-style=tango --natbib --pdf-engine=pdflatex"
	eval $command
	open "$filename.pdf"
}

# shortcut git 
gcp () { git add -A && git commit -m "$@" && git push; }

alias status='git status'
alias branch='git branch -r'
alias grh='git reset --hard'
alias poussin='git pull'

# set defautl version of java
#export JAVA_HOME="`/usr/libexec/java_home -v 1.8`"  use for sbt
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home"	# use for javafx
export PATH="$JAVA_HOME/bin:$PATH"

# flutter
export PATH="$PATH:/Users/pierrecolson/flutter/bin"

# zsh plugin 
source $ZSH_PLUGIN_PATH/please.plugin.zsh
source $ZSH_PLUGIN_PATH/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGIN_PATH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_PLUGIN_PATH/zsh-you-should-use/you-should-use.plugin.zsh

# generate QRCode
qrcode () {
	java -jar "$QRCODE_JAR_PATH" "$@" ;
}

# password manager shortcut
# was supposed to source the correct file
# modified version of https://github.com/caillouc/terminalPasswordManager
p (){
	DIR="`pwd`"
	builtin cd $PASSWORD_MANAGER_PATH
	git checkout perso > /dev/null 2>&1
	case $1 in
		"add") python3 passw.py add "$2"         ;;
		"get") python3 passw.py get "$2"         ;;
		"see") python3 passw.py see "$2"         ;;
		"delete") python3 passw.py delete "$2"   ;;
		"edit") python3 passw.py edit "$2"       ;;
		*) echo "Unvalid argument (add, get, see, delete or edit)"           ;;
	esac
	git checkout master > /dev/null 2>&1
	builtin cd $DIR
}

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
		python3 $ENCODER_PATH/encoder.py decode "$DIR/$1"
	fi
}

neofetch

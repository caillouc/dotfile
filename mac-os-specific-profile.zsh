# To use autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# display or not the hidden file in finder 
alias hidefile='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias showfile='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'	
alias f='open -a Finder ./'                     # Open the current directory in finder

# set defautl version of java
# export JAVA_HOME="`/usr/libexec/java_home -v 1.8`" #  use for sbt
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_241.jdk/Contents/Home"	# use for javafx
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# export TERM=xterm-256color-italic
export TERM=xterm-256color

export EDITOR="/usr/local/bin/nvim"

# Export path for flutter
export PATH="$PATH:$PROG_PATH/flutter/bin"

sp () {
	mv -f "$@" ~/.Trash 
}

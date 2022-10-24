# To use autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# display or not the hidden file in finder 
alias hidefile='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
alias showfile='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'	
alias f='open -a Finder ./'                     # Open the current directory in finder

export EDITOR="/usr/local/bin/nvim"

sp () {
	mv -f "$@" ~/.Trash 
}

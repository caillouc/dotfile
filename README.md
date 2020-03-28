# Mac os terminal dot file

## Zshrc 

Template for a mac os zshrc file. 

You can add your own command in `own_command.zsh`

To use this file add this line to your  `~/.zshrc` file
```bash 
source ~/PATH/TO/FILE/profile.zsh
```

To use `gpdf ()` command you need to install pandoc, this can be done with this command if homebrew is install :
```bash 
brew install pandoc
```

If homebrew is not install see this [link](https://brew.sh)

## Zsh theme

zsh theme similar to default bash theme

Add the file to `~/.oh-my-zsh/custom/themes` then add this line to your `~/.zshrc` (this line is already include in `profile.zsh`)

```bash 
ZSH_THEME="nice"
```

## Vimrc 

Vimrc file (randomly choose one theme between two vim theme I like)

Add this line to your  `~/.vimrc` file

```bash 
source ~/PATH/TO/FILE/vimrc.vim
```



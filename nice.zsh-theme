# add "source PATH/TO/THIS/FILE" in ~/.oh-my-zsh/custom/themes/name_of_your_theme.zsh-theme

setopt prompt_subst

export CLICOLOR=1
export LSCOLORS=Exfxcxdxbxegedabagacad

PROMPT="%(?:%{$fg_bold[green]%}%n :%{$fg_bold[red]%}%n )"
PROMPT+='%{$fg_bold[blue]%}%2~ $(git_prompt_info)%{$reset_color%}%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$fg[red]%}"

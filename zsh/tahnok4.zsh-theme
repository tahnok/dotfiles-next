PROMPT="%(?:%{$fg_bold[green]%}»:%{$fg_bold[red]%}»)"
PROMPT+="%{$fg_bold[magenta]%}%(1j. +.)%{$reset_color%}"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

RPROMPT=''
RPROMPT+='$(virtualenv_prompt_info) '
RPROMPT+='%T'

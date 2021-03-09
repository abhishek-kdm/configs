autoload -U colors && colors

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' \033[1;31m!' # (:A) intentional leading space.
zstyle ':vcs_info:*' stagedstr '\033[1;32m+'
zstyle ':vcs_info:*' formats '\033[0m(\033[1;34m%b%u%c\033[0m)'
zstyle ':vcs_info:git*+set-message:*' hooks git-spacing

# (:A) add spacing between branch info and changes (if exists).
+vi-git-spacing() {
  [ -z "${hook_com[unstaged]}" ] && [ -n "${hook_com[staged]}" ] \
    && hook_com[staged]=" ${hook_com[staged]}"
}

precmd() {
  vcs_info
}

git_info() {
  local LAMBDA="%(?,%{$fg_bold[green]%}λ,%{$fg_bold[red]%}λ)%{$reset_color%}"
  [ -z "$vcs_info_msg_0_" ] && \
    echo " $LAMBDA" ||
    echo " ${vcs_info_msg_0_}\n$LAMBDA"
}
ME="%(!.%{$fg[red]%}%n%{$reset_color%}.%{$fg[cyan]%}%n%{$reset_color%})"

PS1=$'\n'"%{$fg[red]%}[${ME}%B%{$fg[blue]%}@%b%{$fg[white]%}%m %{$fg[magenta]%}\
%3~%{$reset_color%}%{$fg[red]%}]"$'$(git_info)'"%{$reset_color%} "


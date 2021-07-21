new() {
  [ -z "$1" ] && args=() || args=(-s $1)
  tmux -2 new-session "${args[@]}" -n "shell" \; new-window -d -n "code"
}

open() {
  ls -Al "$SCM" \
    | egrep '^d' \
    | awk '{print $NF}' \
    | fzf \
    | xargs -i $EDITOR --cmd "cd $SCM/{}" "$SCM/{}"
}
bindkey -s '^o' "open\n"

conf() {
  find "$SCM"/dotfiles/.* -type f -not -regex ".*\.git\/?.*" \
    | sed -rn 's/.*dotfiles\/(.*)$/\1/p' \
    | fzf \
    | xargs -i $EDITOR "$SCM"/dotfiles/{}
}
bindkey -s '^p' "conf\n"

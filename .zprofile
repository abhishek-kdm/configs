# XDG Base directory specifications.
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

export LC_ALL=en_US.UTF-8
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export SUDO_ASKPASS="$HOME/.local/bin/dmenu/dmenu_askpass"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

export STACK_ROOT="$XDG_DATA_HOME/stack"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export TERMINAL="st"
export EDITOR="nvim"
export VISUAL="$TERMINAL -e nvim"
export BROWSER="brave-browser"
export LAUNCHER="dmenu_launcher"
export SCREENLOCK="slock"

export SCM="$HOME/xkcd/scm"
export WALLPAPERS="$XDG_DATA_HOME/wallpapers"

# zsh key delay (mostly for vi mode).
export KEYTIMEOUT=1
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$XDG_DATA_HOME/zsh/zsh_history"
# oh-my-zsh stuff.
export ZSH="$ZDOTDIR/oh-my-zsh"
export ZSH_THEME="simple-lambda"

export LESSHISTFILE="/dev/null"
export FZF_DEFAULT_OPTS="--border"

# Path Settings.
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.cabal/bin" ] && PATH="$HOME/.cabal/bin:$PATH"
[ -d "$CARGO_HOME" ] && PATH="$CARGO_HOME/bin:$PATH"
[ -d "$GOPATH" ] && PATH="$GOPATH/bin:$PATH"

LOCAL_BIN="$HOME/.local/bin"
if [ -d "$LOCAL_BIN" ];
then
  for DIR in $(ls "$LOCAL_BIN");
  do
    [ -d "$LOCAL_BIN/$DIR" ] && PATH="$LOCAL_BIN/$DIR:$PATH"
  done
  PATH="$LOCAL_BIN:$PATH"
fi
unset LOCAL_BIN

export PATH


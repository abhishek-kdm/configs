export LC_ALL=en_US.UTF-8

############################## 'oh my zsh' stuff. ##############################
if [ ! -d "$ZSH" ];
then
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
  echo "cleaning up orphan '.zshrc' files."
  rm -rf $HOME/.zshrc*
fi

ZSH_THEME_FILE="$ZSH/themes/simple-lambda.zsh-theme"
if [ ! -f "$ZSH_THEME_FILE" ];
then
  THEME_FILE="https://raw.githubusercontent.com/lycuid/simple-lambda-zsh-theme/master/simple-lambda.zsh-theme"
  curl -o $ZSH_THEME_FILE $THEME_FILE 2> /dev/null
  unset THEME_FILE
fi
unset ZSH_THEME_FILE

plugins=(git)
source $ZSH/oh-my-zsh.sh

[ -f "$XDG_CONFIG_HOME/shell/aliases" ] && . "$XDG_CONFIG_HOME/shell/aliases"

# vim mode.
bindkey -v

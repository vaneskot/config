if ([ -n "$SSH_CLIENT" ] || [ -n "$SSH_USER" ]) && [ $TERM != "screen-256color" ];
then
  tmux attach || tmux new
fi
. ~/.bash/.bashrc
export ENV=$HOME/.bash/.bashrc
. ~/.bash/.bash_aliases
. ~/.bash/git-completion.bash
export PATH=$HOME/bin:$HOME/scripts:/usr/local/bin:$PATH
ANDROID_HOME=$HOME/download/adt-bundle-linux-x86_64-20131030/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
if [[ $platform == 'Darwin' ]]; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

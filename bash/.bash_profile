if ([ -n "$SSH_CLIENT" ] || [ -n "$SSH_USER" ]) && [ $TERM != "screen-256color" ];
then
  tmux attach || tmux new
fi
. ~/.bash/.bashrc
export ENV=$HOME/.bash/.bashrc
. ~/.bash/.bash_aliases
. ~/.bash/git-completion.bash
export PATH=$HOME/homebrew/bin:$HOME/bin:$HOME/scripts:/usr/local/bin:$PATH
if [[ $platform == 'Darwin' ]]; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

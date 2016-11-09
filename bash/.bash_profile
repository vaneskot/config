if [ -n "$SSH_CLIENT" ] && [ $TERM != "screen-256color" ];
then
  screen -R
fi
. ~/.bash/.bashrc
export ENV=$HOME/.bash/.bashrc
. ~/.bash/.bash_aliases
. ~/.bash/.bash_aliases_browser
. ~/.bash/git-completion.bash
export PATH=$HOME/projects/depot_tools_ya:$HOME/bin:$HOME/scripts:/usr/local/bin:$PATH
export GYP_GENERATORS=ninja
ANDROID_HOME=$HOME/download/adt-bundle-linux-x86_64-20131030/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/download/adt-bundle-linux-x86_64-20131030/eclipse
export PATH=$PATH:$HOME/Applications/Arduino.app/Contents/MacOs
if [[ $platform == 'Darwin' ]]; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

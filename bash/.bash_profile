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
if [[ $platform == 'Darwin' ]]; then
  [[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

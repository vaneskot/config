alias cp2utf='iconv -f cp1251 -t utf8'

alias moke='make 2>&1 | more'

alias cmake_debug='cmake -DCMAKE_BUILD_TYPE="Debug"'
alias cmake_release='cmake -DCMAKE_BUILD_TYPE="Release"'


if [[ $platform == 'Darwin' ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -A'

alias du='du -h'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ack='ack --ignore-file=is:tags --ignore-file=ext:out'
alias node='/usr/local/bin/node'

alias ..='cd ..'
alias ...='cd .. ; cd ..'

alias src='. ~/.bash_profile'

if [[ $platform == 'Darwin' ]]; then
  alias qmake='qmake -spec macx-g++'
  alias pr_create='create-pull-request.rb -f origin -u origin/master --no-jira-link -s'
  alias pr_create_merge='create-pull-request.rb -f kotenkov --no-jira-link -s -u'
fi

shad_activate=$HOME/virtualenv/shad-env/bin/activate
if [ -f $shad_activate ]; then
  alias activate-shad="source $shad_activate"
  alias notebook='ipython notebook --pylab=inline'
fi

alias bchrome='anybar red && ninja -j 24 -C out/Debug chrome; anybar green'
alias bweb='anybar red && ninja -j 24 -C out/Debug webkit_unit_tests; anybar green'
alias bbtests='anybar red && ninja -j 24 -C out/Debug browser_tests custo_browser_tests; anybar green'
alias bgyp='anybar red && gclient sync && sh ~/projects/gyp_dist_clang.sh; anybar green'
alias bgchrome='bgyp && bchrome'

alias sshbro='ssh kotenkov.haze.yandex.net'
alias sshstats='ssh browser-git-stats.haze.yandex.net'
alias sshnewton='ssh koteniv1@fray1.fit.cvut.cz -L 16286:newton.fit.cvut.cz:16286'
alias sshfray='ssh koteniv1@fray1.fit.cvut.cz'
alias sshstar='ssh koteniv1@star.fit.cvut.cz'

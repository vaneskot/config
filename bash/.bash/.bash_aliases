alias cp2utf='iconv -f cp1251 -t utf8'

alias moke='make 2>&1 | more'

alias cmake_debug='cmake -DCMAKE_BUILD_TYPE="Debug"'
alias cmake_release='cmake -DCMAKE_BUILD_TYPE="Release"'

alias ls='ls -G'
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -A'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ack='ack --ignore-file=is:tags --ignore-file=ext:out'

alias ..='cd ..'
alias ...='cd .. ; cd ..'

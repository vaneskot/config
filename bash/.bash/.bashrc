export CLICOLOR=1  
export LSCOLORS=Gxfxcxdxbxegedabagacad

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

platform=`uname`

function battery_info()
{
  capacity_perc=''
  if [[ $platform == 'Linux' ]]; then
    if [ hash acpi 2>/dev/null ]; then
      capacity_perc=`acpi | awk '{ print $4 }' | sed 's/,$//'`
    fi
  elif [[ $platform == 'Darwin' ]]; then
    capacity_cur=`ioreg -c AppleSmartBattery -w0 | grep CurrentCapacity | awk '{print $5}'`
    capacity_max=`ioreg -c AppleSmartBattery -w0 | grep MaxCapacity | awk '{print $5}'`
    #capacity_perc=`awk "BEGIN{print $capacity_cur/$capacity_max}" | awk '{print(substr($0, 3, 2) "%")}'`
    capacity_perc=`expr $capacity_cur \* 100 / $capacity_max`"%"
  fi
  echo $capacity_perc
}

if [[ $platform == 'Darwin' ]]; then
  pman() { man -a -t "${1}" | open -f -a /Applications/Preview.app; }
fi

. ~/.bash/git-prompt.sh

PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w \[\033[1;35m\]\D{%T} $(battery_info) \[\033[01;31m\]$(__git_ps1 "(%s)")\n\[\033[00m\]\$ '

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

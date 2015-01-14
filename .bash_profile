# Global - Useful Variables

export SVN_EDITOR=vim
export HISTSIZE='999'
export HISTFILESIZE="${HISTFILESIZE}";

# Global - Useful Aliases

alias e='echo'
alias c='clear'
alias h='history'
alias quit='exit'
alias reload='. ~/.bashrc'
alias edit='vim ~/.bash_profile'
alias ..='cd ..'
alias _='cd -'
alias c='cd'
alias ls='ls --color=auto'
alias l='ls -lh'
alias la='ls -A'
alias lal='ls -alh'
alias ll='ls -lh'
alias lll='ls -alh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias df='df -Ph'
alias di='df -Phi'
alias df='df -P'
alias ports='netstat -tulanp'
alias s='ssh'

# ArchLinux - Useful Aliases for my laptop

if grep --quiet 'Arch Linux' /etc/os-release 2>/dev/null ; then
  alias brightness='sudo /root/brightness/brightness.sh'
  alias halt='sudo halt -p'
  alias reboot='sudo reboot'
  alias charge='acpi -V'
fi

# Utilities Functions

# function is_integer
function is_integer(){ # check if arg $1 is integer
  [[ "${1}" =~ ^[0-9]+$ ]] && return 0 || return 1
}

# Global Useful Functions

# function for root user
if [ "$(whoami)" = 'root' ] ; then
	# function scsi_scan
  function scsi_scan(){ # scan scsi's host
    echo "- - -"|tee /sys/class/scsi_host/host*/scan >/dev/null
  }
fi

# function whichregex
function whichregex(){ # which with regex * extension support
  for i in $(echo ${PATH}|sed 's/:/ /g') ; do
    if [ -e "${i}" ] ; then
      find ${i} -type f -name ${1}
    fi
  done
}

# function echoerr
function echoerr(){ # echo to stderr
  echo ${@} 1>&2
}

# function conf
function conf(){ # read conf file without comments and blank lines
  sed -e '/#.*$/d;/^$/d' ${1}
}

# function check_size
function _check_size(){ # display bigest files and dir in current dir
  is_integer ${1} && number="${1}" || number='10'
  echo " -- ${number} fichiers les plus volumineux :"
  find . -xdev -type f -exec du -s {} \;|sort -rn|head -n${number}
  echo " -- ${number} repertoires les plus volumineux :"
  find . -xdev -type d -exec du -s {} \;|sort -rn|head -n${number}
}

# function extract
function extract(){ # extract some archive files
  file="${1}"

  if [ ! -e "${file}" ] ; then
    echo "File ${file} not found" ; return 1
  fi

  case "${file}" in
    *.tar.bz2) tar xvjf "${1}" ;;
    *.tar.gz)  tar xvzf "${1}" ;;
    *.tar.xz)  tar xvJF "${1}" ;;
    *.bz2)     bunzip2  "${1}" ;;
    *.tar)     tar xvf  "${1}" ;;
    *.tbz2)    tar xvjf "${1}" ;;
    *.tgz)     tar xvzf "${1}" ;;
    *.zip)     unzip    "${1}" ;;
    *.rar)     unrar    "${1}" ;;
    *) echo "extract: ${1} : unknown archive method" ; exit 2 ;;
  esac
}

# function path
function path(){ # show full path for a file
  echo "${pwd}/${1}"
}

# function up
function up(){ # up 2 do cd ../../ ;)
  up="${1}"
  if ! is_integer "${up}" ; then
    echo "arg ${up} is not integer" ; return 1
  fi

  updir="" ; for i in $(seq 1 ${up}) ; do updir="${updir}../" ; done
  cd $updir
}

# function fonction
function fonction(){ # list function in ~/.bash_profile
  grep ' *function [a-z_]*()' ~/.bash_profile|sed 's/^[ ]*function //;s/(.*#/ :/'
}

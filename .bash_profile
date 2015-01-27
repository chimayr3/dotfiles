# Global - Useful Variables

export SVN_EDITOR=vim
export HISTSIZE='999'
export HISTFILESIZE="${HISTFILESIZE}";

# Color Terminal

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White
# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

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
alias v='vim'
alias vi='vim'
alias ports='netstat -tulanp'
alias s='ssh'
alias s2='ssh -p 2222'

# ArchLinux - Useful Aliases for my laptop

if grep --quiet 'Arch Linux' /etc/os-release 2>/dev/null ; then
  # source alias for wifi connection
  source ~/.alias_wifi
  # source alias for servers connection
  source ~/.alias_server
  alias brightness='sudo /root/brightness/brightness.sh'
  alias halt='sudo halt -p'
  alias reboot='sudo reboot'
  alias charge='acpi -V'
  alias vnc='vinagre'
  alias pdf='evince'
  alias music='mocp'
  alias top='htop'
  alias ff='firefox'
  alias kp='keepassx'
  alias pacupdate='pacman -Syu'
  alias pacsearch='pacman -Ss'
  alias pacinstall='pacman -S'
  alias pacremove='pacman -R'
  alias pacinfo='pacman -Si'
  alias paclistfile='pacman -Ql'
  alias paccleancache='pacman -Sc'
  alias pacdownload='pacman -Sw'
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
function _check_size(){ # display biggest files and dir in current dir
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

# function mktar
function mktar(){ # make tar archive
  tar -cvf "${1%%/}.tar" "${1}"
}

# function mktgz
function mktgz(){ # make tar.gz archive
  tar -cvzf "${1%%/}.tar.gz" "${1}"
}

# function mcd
function mcd(){ # do mkdir $1 ; cd $1
  mkdir -p "${1}" && cd "${1}"
}

function lcd(){ # do cd $1 and ls 
  cd "${1}" && ls
}

# function path
function path(){ # show full path for a file
  echo "${pwd}/${1}"
}

# function up
function up(){ # up 2 do cd ../../ ;)
 is_integer "${1}" && for i in $(seq 1 ${1}) ; do cd .. ; done \
    || echo "arg ${1} is not integer"
}

# function fonction
function fonction(){ # list function in ~/.bash_profile
  grep ' *function [a-z_]*()' ~/.bash_profile|sed 's/^[ ]*function //;s/(.*#/ :/'
}

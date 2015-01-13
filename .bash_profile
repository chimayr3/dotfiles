# Global - Useful Variables

export SVN_EDITOR=vim
export HISTSIZE='999'
export HISTFILESIZE="${HISTFILESIZE}";

# Global - Useful Aliases

alias ..='cd ..'
alias c='clear'
alias df='df -h'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias h='history'
alias ls='ls --color=auto'
alias l='ls -lh'
alias la='ls -A'
alias lal='ls -alh'
alias ll='ls -lh'
alias lll='ls -alh'
alias ports='netstat -tulanp'
alias quit='exit'
alias reload='. ~/.bashrc'
alias s='ssh'

# ArchLinux - Useful Aliases for my laptop

if grep --quiet 'Arch Linux' /etc/os-release 2>/dev/null ; then
  alias brightness='sudo /root/brightness/brightness.sh'
  alias halt='sudo halt -p'
  alias charge='acpi -V'
fi

# Global Useful Functions

# _scsi_scan : scan scsi host (only for root)
if [ "$(whoami)" = 'root' ] ; then
  function _scsi_scan(){
    echo "- - -"|tee /sys/class/scsi_host/host*/scan >/dev/null
  }
fi

function _whichregexp(){
  for i in $(echo ${PATH}|sed 's/:/ /g') ; do find ${i} -type f -name ${1} ; done
}

# User specific functions

# _whichregexp : like which with regexp * extenson support
function _whichregexp(){
  for i in $(echo ${PATH}|sed 's/:/ /g') ; do
    if [ -e "${i}" ] ; then
      find $i -type f -name ${1}
    fi
  done
}

# _echoerr : echo to sdterr
function _echoerr(){
  echo ${@} 1>&2
}

# _catconf : read (conf) file without comment and blank line
function _catconf(){
  sed -e '/^#/d;/^$/d' ${1}
}


# _check_size : display bigest files and directories on current dir
function _check_size(){
  test -z ${1} && number="10" || number="${1}"
  echo " -- ${number} fichiers les plus volumineux :"
  find . -xdev -type f -exec du -s {} \;|sort -rn|head -n${number}
  echo " -- ${number} repertoires les plus volumineux :"
  find . -xdev -type d -exec du -s {} \;|sort -rn|head -n${number}
}

function extract(){
  file="${1}"

  if [ ! -e "${file}" ] ; then
    echo "File ${file} not found" ; exit 1
  fi

  case ${file} in
    *.tar.bz2) tar xvjf "${1}" ;;
    *.tar.gz)  tar xvzf "${1}" ;;
    *.tar.xz)  tar xvJF "${1}" ;;
    *.bz2)     bunzip2 "${1}"  ;;
    *.tar)     tar xvf "${1}"  ;;
    *.tbz2)    tar xvjf "${1}" ;;
    *.tgz)     tar xvzf "${1}" ;;
    *.zip)     unzip "${1}"    ;;
    *) echo "extract: ${1} : unknown archive method" ; exit 2 ;;
  esac
}

function _path(){
  echo ${pwd}/${1}
}


#
# Configuration des alias
#

# ls
alias ls='ls --color -h'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias l='ls'

# lsmod
alias lsmod='lsmod | sort'

# human
alias df='df -h'
alias du='du -h'

# rm
alias rm='rm -i'
alias rmtorrent='rm -rf *.torrent'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'

# apt
alias apt-install='apt-get install'
alias apt-search='apt-cache search'
alias apt-update='apt-get update'
alias apt-remove='apt-get purge'
alias apt-upgrade='apt-get upgrade'

# sudo
alias sudo='sudo DISPLAY=$DISPLAY'
alias apt-get='sudo apt-get'
alias reboot='sudo reboot'
alias visu='sudo vi'
alias service='sudo service'
alias updatedb='sudo updatedb'

# /sbin
alias ifconfig='/sbin/ifconfig'

# grep
alias igrep='grep -i'

# fmkdir
function fmkdir() {
	command mkdir $1 && cd $1
}

# history
history() {
  if [ $# == 0 ]; then
      command history
  else
      command history | igrep "$1"
  fi
}

# ps
ps() {
  if [ $# == 0 ]; then
      command ps aux
  else
      command ps aux | igrep "$1"
  fi
}

# extract
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# change le titre du terminal
set_title() { printf "\e]2;$*\a"; }

# npm install global
alias npm-install='sudo npm install -g'

pathprepend() {
	for ARG in "$@"
	do
		if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
			PATH="$ARG${PATH:+":$PATH"}"
		fi
	done
}

# GIT
alias develop='git checkout develop'
alias master='git checkout master'
ignore() {
	echo "$1" >> .gitignore 
}
# source https://www.synbioz.com/blog/les_aliases_git_de_l_extreme
alias state='git fetch --prune ; git fetch --tags ; clear && git branch -vv && git status'
git-update() {
  branch=$1

  if [[ -z $branch ]]
  then
    branch=`git symbolic-ref HEAD | cut -d "/" -f 3-`
  else
    git checkout $branch
  fi

  git pull --rebase origin $branch
}

alias update='git-update'

git-updates() {
  git stash && git-update "$@" && git stash pop
}

alias updates='git-updates'

alias tagz='git tag -l | sort -V'
alias nxtrlz='tagz | tail -n 1 && git log --oneline `tagz | tail -n 1`..HEAD'

git-merged() {
  sourceBranch=`git symbolic-ref HEAD | cut -d "/" -f 3-`
  targetBranch=$1

  if [[ -z $targetBranch ]]
  then
    targetBranch='master'
  fi

  git-update $targetBranch && git branch -d $sourceBranch
}

alias merged='git-merged'

git-mergeds() {
  git stash && git-merged "$@" && git stash pop
}

alias mergeds='git-mergeds'

git-lstcmt() {
  git log --oneline $1 | grep -v fixup | head -n 1 | cut -d " " -f 1
}

alias lstcmt='git-lstcmt'

git-logz() {
  nb=$2

  if [[ -z $nb ]]
  then
      nb=10
  fi

  git log --oneline $1 | head -n $nb
}

alias logz='git-logz'

git-rebase() {
  sourceBranch=`git symbolic-ref HEAD | cut -d "/" -f 3-`
  targetBranch=$1

  if [[ -z $targetBranch ]]
  then
    targetBranch='master'
  fi

  git-update $targetBranch && git checkout $sourceBranch && git rebase $targetBranch
}

alias rebase='git-rebase'

alias goon='git add . && git rebase --continue || git rebase --skip'

git-rebases() {
  git stash && git-rebase "$@" && git stash pop
}

alias rebases='git-rebases'

git-squash() {
  ref=$1

  if [[ -z $ref ]]
  then
    ref=`git log --oneline | grep -v fixup | head -n 2 | tail -n 1 | cut -d " " -f 1`
  fi

  git rebase -i --autosquash $ref
}

alias squash='git-squash'

git-fixup() {
  ref=$1

  if [[ -z $ref ]]
  then
    ref=`lstcmt`
  fi

  git commit --fixup $ref
}

alias fixup='git-fixup'

alias fixupa='adal && fixup'

alias adal='git add --all .'

alias amend='git commit --amend --no-edit'
alias amenda='adal && amend'

alias yolo='git push origin HEAD --force-with-lease'

alias yoloc='amend && yolo'
alias yoloca='adal && yoloc'
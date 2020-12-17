parse_git_branch() {
    f='└── '
    g=$(git branch 2>/dev/null | grep '^*' | colrm 1 2)
    if [ -z "$g" ]
    then
      echo
    else
      echo 
      echo "$f($g)"
    fi
}
PS1='\D{%T} ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] $(parse_git_branch)\n\[\033[00m\]└── \[\033[01;34m\]\w\[\033[00m\]\$ '

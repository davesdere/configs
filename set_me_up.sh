alias lg="git log --all --decorate --oneline --graph"
git_branch() {
    git branch 2>/dev/null | grep '^*' | colrm 1 2
}



# Two lines ps1
PS1='\D{%T} ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\]\n\[\033[00m\]└── \[\033[01;34m\]\w\[\033[00m\]\$ '
# Add git to ps1
PS1='\D{%T} ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]\[\033[01;34m\] ( $(git_branch) )\n\[\033[00m\]└── \[\033[01;34m\]\w\[\033[00m\]\$ '

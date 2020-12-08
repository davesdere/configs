alias lg="git log --all --decorate --oneline --graph"
parse_git_branch() {
     git branch >2 /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (/1)/'
}

PS1='\D{%T} $(parse_git_branch)\n${PS1}'

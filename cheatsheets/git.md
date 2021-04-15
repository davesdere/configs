# GIT
`git config --global credential.helper 'cache --timeout=600'`  
## Renaming branches
```
# On local branch
#TODO: Command to change it remote first
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
```

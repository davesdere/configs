# GIT

`git config --global credential.helper 'cache --timeout=600'`

## Submodules    
```
GIT_USER="davesdere"  
GIT_REPO_NAME="configs"  
git submodule add https://github.com/$GIT_USER/$GIT_REPO_NAME`  
```  

## Renaming branches  
```
# On local branch
#TODO: Command to change it remote first
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
```
## TAGS  
```
# Tag local branch
# Push tags on remote
# Clear all tags locally
# Delete remote tags
```

## Merging  
```
# Adding files to a MAIN branch. AKA Merging into MAIN
```
## Rebasing  
```
# Squash commits
```

## Undo
```
git reset --hard
git rm --cached $FILENAME
```
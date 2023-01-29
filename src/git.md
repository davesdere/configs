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

## Deleting main branch history  
```
# Cowboy rebase  
git branch -m master master-old  # rename master on local
git push origin :master          # delete master on remote
git push origin master-old       # create master-old on remote
git checkout -b master seotweaks # create a new local master on top of seotweaks
git push origin master           # create master on remote

# Cowgirl rebase
git push origin master:master-old        # 1
git branch master-old origin/master-old  # 2
git reset --hard $new_master_commit      # 3
git push -f origin                       # 4

# Clean main branch refactor Git >=v1.7  
git branch -m old_branch new_branch         # Rename branch locally    
git push origin :old_branch                 # Delete the old branch    
git push --set-upstream origin new_branch   # Push the new branch, set local branch to track the new remot
```
# Git Hooks.
`pre-commit` file to validate JSON syntax  
```python
#!/usr/bin/env python
import json
import sys

# Check the syntax of all JSON files in the repository
for file in `git diff-index --cached --name-only HEAD | grep .json`:
    try:
        with open(file) as f:
            json.load(f)
    except json.JSONDecodeError as e:
        print("Error: Invalid JSON syntax in file %s: %s" % (file, e))
        sys.exit(1)

```
As a pytest file. 
```import json
import os
import subprocess

def test_json_syntax():
    current_branch = subprocess.run(["git", "rev-parse", "--abbrev-ref", "HEAD"], capture_output=True).stdout.strip().decode("utf-8")
    assert current_branch == "main", f"This test should be run only in main branch, but it was run on {current_branch} branch"
    for file in subprocess.run(["git", "diff-index", "--cached", "--name-only", "HEAD"], capture_output=True).stdout.strip().decode("utf-8").split("\n"):
        if file.endswith(".json"):
            with open(file) as f:
                json.load(f)

# To commit if test passes
subprocess.run(["git", "commit", "-am", "valid json files"])


```
## GitHub  
 - ### [Email Address privacy](https://docs.github.com/en/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address)
```bash
# https://docs.github.com/en/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address
# TL;DR : # https://stackoverflow.com/questions/43863522/error-your-push-would-publish-a-private-email-address/51097104#
git config user.email "{ID}+{username}@users.noreply.github.com"
git commit --amend --reset-author
git push
```  
 - ### [Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets)
    - Workflow 
        ```bash
        steps:
        - name: Hello world action
            with: # Set the secret as an input
            super_secret: ${{ secrets.SuperSecret }}
            env: # Or as an environment variable
            super_secret: ${{ secrets.SuperSecret }}

        ```
    - Bash script 
        ```bash
        steps:
        - shell: bash
            env:
            SUPER_SECRET: ${{ secrets.SuperSecret }}
            run: |
            example-command "$SUPER_SECRET"

        ```

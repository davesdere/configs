```kubernetes.md
 _  __     _                          _
| |/ /   _| |__   ___ _ __ _ __   ___| |_ ___  ___
| ' / | | | '_ \ / _ \ '__| '_ \ / _ \ __/ _ \/ __|
| . \ |_| | |_) |  __/ |  | | | |  __/ ||  __/\__ \
|_|\_\__,_|_.__/ \___|_|  |_| |_|\___|\__\___||___/
```  

A help guide to learn and debug Kubernetes.   


The easiest setup if you are running Windows 10 Pro or Home is to use the WSL2 with Docker or just bite the bullet and use a Cloud provider right away.

The Cloud provider way is easier but is more pricey.

## Local setup  

Windows 10 Pro with WSL2  
0. Install WSL2 and get it to work with internet access.
1. Install Docker  
2. [Install Golang](https://medium.com/@benzbraunstein/how-to-install-and-setup-golang-development-under-wsl-2-4b8ca7720374)
3. [Install Kind](https://kind.sigs.k8s.io/)
4. Create a cluster if you have Docker permission error. Configure Docker permission properly or be lazy with `sudo env "PATH=$PATH" kind create cluster` **At your  own risk** You could even add `alias superkind='sudo env "PATH=$PATH" kind'` to your `~/.bashrc`
5. Install Kubectl
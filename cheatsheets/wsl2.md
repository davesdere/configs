# WSL2  
When you have no internet or DNS resolution in WSL2  

# 1- No internet  
First make sure that the device is up
```sh
ip address show
```
## If it's down, well fix it...  
```sh
ip link set dev eth0 up
```
# 2- Dns doesn't resolve  
Check if the `/etc/resolv.conf` file is automatically generated, by checkign the file `/etc/wsl.conf`
This file should contain  
```ini
[network]
generateResolvConf = false
```
## Then in WSL2 run
```bash
sudo rm /etc/resolv.conf && sudo bash -c 'echo "nameserver 1.1.1.1" > /etc/resolv.conf' && sudo chattr +i /etc/resolv.conf
```  
This will set your DNS server to CloudFlare. I suggest you add the fallback DNS too. `1.0.0.1`.
## Then in CMD.exe run
```cmd.exe
wsl --shutdown Ubuntu-20.04
wsl --terminate Ubuntu-20.04
wsl --shutdown Ubuntu-20.04
wsl -d Ubuntu-20.04
```

# Done!

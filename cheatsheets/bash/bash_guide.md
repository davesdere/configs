# Download a file with wget (Automatic retry -c)
```bash
wget -c --tries=inf --wait=10 --waitretry=10 http://youreFile.iso
```
# Delete history lines  
`history -d 511-520`  
or counting backwards 10  
`history -d -10--1`  

# Deletes lines of history that contains a string
```

history -d $(history | grep $this_string | awk '{print $1} | head -n 1')

count=$(history | grep $this_string | awk '{print $1}' | wc -l)
for line in $lines;do echo history -d $(history | grep $this_string | awk '{print $1} | head -n 1'); done

```
```bash
echo "hidden command" && history -d $(history 1 | awk '{print $1}')
```

# Checksum validation
```bash
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

echo "$(cat ${CHECKSUMFILE})  ${FILENAME}" | sha256sum --check
```

```
script_exit()
{
    if [ -z "$1" ]; then
        echo "[!] INTERNAL ERROR. script_exit requires an argument" >&2
        exit 1
    fi

    if [ -n $DEBUG ]; then
        print_state
    fi

    if [ "$2" = "0" ]; then
        echo "[v] $1"
    else
	    echo "[x] $1" >&2
    fi

    if [ -z "$2" ]; then
        exit 1
    else
        echo "[*] exiting ($2)"
	    exit $2
    fi
}
```
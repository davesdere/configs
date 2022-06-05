# Download a file with wget (Automatic retry -c)
```bash
wget -c --tries=inf --wait=10 --waitretry=10 http://youreFile.iso
```
# Delete history lines  
`history -d 511-520`  
or counting backwards 10  
`history -d -10--1`  

```bash
echo "hidden command" && history -d $(history 1 | awk '{print $1}')
```

# Checksum validation
```bash
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

echo "$(cat ${CHECKSUMFILE})  ${FILENAME}" | sha256sum --check
```
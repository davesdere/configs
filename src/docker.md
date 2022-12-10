# Docker  

## Run docker as non-root
`sudo groupadd docker`
`sudo usermod -aG docker $USER`
Log out and log back in so that your group membership is re-evaluated
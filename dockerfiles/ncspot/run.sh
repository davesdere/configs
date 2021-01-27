docker run -it -v /etc/localtime:/etc/localtime:ro  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --name ncspot101 davesdere/ncspot


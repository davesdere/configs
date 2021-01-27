#docker run -it \
#    -v /etc/localtime:/etc/localtime \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \ # mount the X11 socket
#    -e DISPLAY=unix$DISPLAY \ # pass the display
#    --device /dev/snd \ # sound
#    --link pulseaudio:pulseaudio \ # link pulseaudio
#    -e PULSE_SERVER=pulseaudio \
#    --device /dev/video0 \ # video
#    --name ncspot \
#     davesdere/ncspot
FROM ubuntu:latest
RUN apt-get update -y && apt-get -y install vim
RUN apt-get install -yqq daemonize dbus-user-session fontconfig
RUN daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target
RUN nsenter --help
RUN apt-get install -y cargo
RUN apt-get install -y librust-libdbus-sys-dev
RUN apt-get install -y libpulse-dev libncurses-dev libssl-dev libdbus-1-dev 
RUN apt install -y libncursesw5-dev libdbus-1-dev libpulse-dev libssl-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev
RUN apt -y remove rustc || echo "Rust not installed"
RUN apt-get install -y curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > run.sh
RUN chmod +x run.sh
RUN sh ./run.sh -y
RUN /root/.cargo/bin/cargo install ncspot
#RUN source $HOME/.cargo/env
#RUN cargo install ncspot

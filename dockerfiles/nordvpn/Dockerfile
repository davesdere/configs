FROM ubuntu:20.04
ARG VERSION=3.7.4
RUN apt update && \
       apt install -y wget && \
       wget -O /tmp/nordrepo.deb https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb && \
       apt install -y /tmp/nordrepo.deb && \
       apt update && \
       apt install -y nordvpn=$VERSION && \
       apt remove -y wget nordvpn-release

ENTRYPOINT ["/usr/sbin/nordvpnd", "&"]
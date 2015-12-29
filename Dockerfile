FROM resin/rpi-raspbian:jessie
MAINTAINER BASEBOXORG
# Enable systemd
ENV DEBIAN_FRONTEND noninteractive

# Install Webmin
RUN apt-get update && \
		apt-get install -y wget nfs-kernel-server runit inotify-tools && \
		locales && \
		dpkg-reconfigure locales && \
		locale-gen C.UTF-8 && \
		/usr/sbin/update-locale LANG=C.UTF-8 && \
		mkdir -p /exports && \
		mkdir -p /etc/sv/nfs && \
		rm -rf /var/lib/apt/lists/*

ADD nfs.init /etc/sv/nfs/run && \
		nfs.stop /etc/sv/nfs/finish && \
		nfs_setup.sh /usr/local/bin/nfs_setup && \

VOLUME ["/exports"]

EXPOSE 111/udp 2049/tcp

ENTRYPOINT ["/usr/local/bin/nfs_setup"]

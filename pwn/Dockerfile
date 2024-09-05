FROM ubuntu:latest

ARG LOWER_ROOTFS_ARCHIVE

# GDB Server port
EXPOSE 1234
EXPOSE 22

WORKDIR /app

# ADD overlay/ /

# Building from scratch
# ADD ${LOWER_ROOTFS_ARCHIVE} /
# ADD rootfs.tar.gz /

RUN echo 'poun\npoun' | passwd

RUN apt-get update \
  && apt-get install -y lib32z1 \
  && apt-get install -y dropbear \
  && apt-get install -y gcc \
  # && apt-get install -y gdbserver \
	# && apt-get install -y gdb \
	# && apt-get install -y wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Dropbear setup
RUN mkdir -p /etc/dropbear \
    && dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key

# bata24 gef setup
# RUN wget -q https://raw.githubusercontent.com/bata24/gef/dev/install.sh
# RUN cat /app/install.sh | sed -e 's/\(pip3 install\)/\1 --break-system-packages/g'
# RUN chmod +x /app/install.sh
# RUN /app/install.sh
# RUN rm /app/install.sh


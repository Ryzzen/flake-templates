FROM ubuntu:latest


RUN apt-get update && apt-get install -y \
    gdbserver \
	&& apt-get install -y gdb \
	&& apt-get install -y wget \
  && apt-get install -y lib32z1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*


WORKDIR /app

RUN wget -q https://raw.githubusercontent.com/bata24/gef/dev/install.sh
RUN cat /app/install.sh | sed -e 's/\(pip3 install\)/\1 --break-system-packages/g'
RUN chmod +x /app/install.sh
RUN /app/install.sh

# GDB Server port
EXPOSE 1234


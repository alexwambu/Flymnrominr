FROM ubuntu:20.04

# Non-interactive to avoid tzdata issues
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git build-essential cmake automake libtool autoconf wget curl && \
    rm -rf /var/lib/apt/lists/*

# Clone xmrig
RUN git clone https://github.com/xmrig/xmrig.git /xmrig
WORKDIR /xmrig
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# Copy config
COPY config.json /xmrig/build/config.json

# Run miner
CMD ["./xmrig", "-c", "config.json"]

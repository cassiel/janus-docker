FROM ubuntu

# Dependencies for Janus:
RUN apt-get update \
    && apt-get install -y libmicrohttpd-dev libjansson-dev libnice-dev libssl-dev \
                          libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev libopus-dev \
                          libogg-dev pkg-config gengetopt libtool automake

# Git, so that we can pull Janus from GitHub:
RUN apt-get install -y git

# Pull Janus:
RUN git clone https://github.com/meetecho/janus-gateway.git

# Attempt the build:
RUN cd janus-gateway \
        && sh autogen.sh \
        && ./configure --prefix=/opt/janus --disable-websockets --disable-data-channels --disable-rabbitmq \
        && make \
        && make install \
        && make configs

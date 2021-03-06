FROM ubuntu

# Dependencies for Janus:
RUN apt-get update \
    && apt-get install -y libmicrohttpd-dev libjansson-dev libnice-dev libssl-dev \
                          libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev libopus-dev \
                          libogg-dev pkg-config gengetopt libtool automake

# Git, so that we can pull Janus from GitHub:
RUN apt-get install -y git

# Set up supervisor:
RUN apt-get update \
        && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# *Temporary*: Emacs for now:
RUN apt-get update \
        && apt-get install -y emacs

# Pull Janus:
RUN cd /root && git clone https://github.com/meetecho/janus-gateway.git

# Attempt the build:
RUN cd /root/janus-gateway \
        && sh autogen.sh \
        && ./configure --prefix=/opt/janus --disable-websockets --disable-data-channels --disable-rabbitmq \
        && make \
        && make install \
        && make configs

# Get gstreamer:
RUN apt-get update \
        && apt-get install -y gstreamer1.0-tools \
                gstreamer1.0-plugins-base \
                gstreamer1.0-plugins-good

# TESTING: extra gstreamer stuff (support for FFMPEG/H.264):
RUN apt-get update \
        && apt-get install -y gstreamer1.0-libav

# Tweak gstreamer test script (kill `error-resilient`):
RUN sed -i 's/error-resilient=true//' /root/janus-gateway/plugins/streams/test_gstreamer_1.sh

# Copy in our test script (although we also mount its folder):
COPY scratch/stream.sh /root/scripts/stream.sh

# Replace configs:
COPY scratch/janus.cfg /opt/janus/etc/janus/config.cfg
COPY scratch/janus.transport.http.cfg /opt/janus/etc/janus/janus.transport.http.cfg

# Go!
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

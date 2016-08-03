#!/bin/bash

# rtspsrc: makes application/x-{rtp,rdt}
# rtph264depay: sinks application/x-rtp, makes video/x-h264
# (h264parse: takes video/x-264, makes video/x-h264 parsed with stream formats)
# avdec_h264: takea video/x-264, makes video/x-raw

# vp8enc: sinks video/x-raw, makes video/x-vp8
# rtpvp8enc: sinks video/x-vp8, makes video/x-rtp
# udpsink: sinks anything

SOURCE=rtsp://mpv.cdn3.bigCDN.com:554/bigCDN/definst/mp4:bigbuckbunnyiphone_400.mp4

GST_DEBUG=2 gst-launch-1.0 rtspsrc location=$SOURCE \
         ! rtph264depay \
         ! avdec_h264 \
         ! timeoverlay \
         ! vp8enc \
         ! rtpvp8pay \
         ! udpsink host=127.0.0.1 port=5004

#!/bin/bash

exec docker run \
     --name 'janus' \
     -p 8088:8088 \
     -p 8000:8000 \
     -p 9003:9003 \
     --rm \
     cassiel/janus-gateway

#!/bin/bash

exec docker run \
     --name 'janus' \
     --interactive \
     --tty \
     -p 8088:8088 \
     -p 8000:8000 \
     --rm \
     cassiel/janus-gateway

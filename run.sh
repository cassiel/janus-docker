#!/bin/bash

exec docker run \
     --interactive \
     --tty \
     -p 8088:8088 \
     cassiel/janus-gateway bash

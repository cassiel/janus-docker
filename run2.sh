#!/bin/bash

CWD=`pwd`

exec docker run \
     --name 'janus' \
     -p 18088:8088 \
     -p 18000:8000 \
     -p 19003:9003 \
     -v $CWD/scratch:/root/scratch \
     --rm \
     cassiel/janus-gateway

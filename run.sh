#!/bin/bash

CWD=`pwd`

exec docker run \
     --name 'janus' \
     -p 7088:7088 \
     -p 8088:8088 \
     -p 8000:8000 \
     -p 9003:9003 \
     -v $CWD/scratch:/root/scratch \
     --rm \
     cassiel/janus-gateway

#!/bin/bash

CONTAINER="openfire"

# Uncomment this to background the container
DAEMON="-d"

# File sharing proxy port
PORTS="-p 0.0.0.0:7777:7777 -p 0.0.0.0:5222:5222 -p 0.0.0.0:9091:9091 -p 0.0.0.0:5269:5269 -p 0.0.0.0:9999:9999 -p 0.0.0.0:9090:9090"

if [ ! -d $(pwd)/etc ] || [ ! -d $(pwd)/lib ]; then
    echo "Please run this from the 'run' directory to access the persistent volumes."
    exit 1
fi

   # this is now taken care of by the add
   #-v $(pwd)/etc:/etc/openfire \
echo "docker -D run $DAEMON $PORTS --name openfire\
  -v $(pwd)/etc:/etc/openfire \
  -v $(pwd)/lib:/var/lib/openfire \
  --cidfile='cid' $CONTAINER"
docker run $DAEMON $PORTS \
  --name openfire \
  -v $(pwd)/lib:/var/lib/openfire \
  --cidfile="cid" $CONTAINER

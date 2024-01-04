#!/bin/sh

# docker run -it --name c1 --privileged ubuntu bash
# exit
# docker start c1

CONTAINER_ID=c;

for i in $(seq 1 7); do

    CONTAINER_ID="$CONTAINER_ID$i"
    docker exec -i $CONTAINER_ID apt-get update
    docker exec -i $CONTAINER_ID apt-get install -y net-tools
    docker exec -i $CONTAINER_ID apt install iproute2 -y
    docker exec -i $CONTAINER_ID apt-get install -y iputils-ping
    docker exec -i $CONTAINER_ID apt-get install -y iperf3

    CONTAINER_ID=c;
done
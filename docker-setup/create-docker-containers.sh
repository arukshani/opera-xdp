#!/bin/bash

echo "hello"

CONTAINER_ID=c;
in_veth_number=1
out_veth_number=1

NODE_INTERFACE=ens2np0;
host_ip_addr=$(ip -f inet addr show $NODE_INTERFACE | awk '/inet / {print $2}')
IFS='.' read ip1 ip2 ip3 ip4 <<< "$host_ip_addr"
fouth_octec=1


for i in $(seq 1 7); do
    

    CONTAINER_ID="$CONTAINER_ID$i"
    INSIDE_VETH="dcin$in_veth_number"
    OUTSIDE_VETH="dcout$out_veth_number"

    ns_ip_addr=$ip1.$ip2.$ip3.$(($fouth_octec + $i))/16

    echo $CONTAINER_ID
    # echo $ns_ip_addr
    # echo $INSIDE_VETH
    # echo $OUTSIDE_VETH

    sudo ip link add $INSIDE_VETH type veth peer name $OUTSIDE_VETH
    
    DOCKER_PROCESS_ID=$(sudo docker inspect --format '{{.State.Pid}}' $CONTAINER_ID)
    # echo $DOCKER_PROCESS_ID
    echo "===================="

    sudo ip link set netns $DOCKER_PROCESS_ID dev $INSIDE_VETH
    sudo ip link set dev $OUTSIDE_VETH up
    sudo ip link set $OUTSIDE_VETH mtu 3400

    docker exec -i $CONTAINER_ID ip link set $INSIDE_VETH up
    docker exec -i $CONTAINER_ID ip addr add $ns_ip_addr dev $INSIDE_VETH
    docker exec -i $CONTAINER_ID ip link set $INSIDE_VETH mtu 3400

    in_veth_number=`expr $i + 1`
    out_veth_number=`expr $i + 1`
    CONTAINER_ID=c;
done
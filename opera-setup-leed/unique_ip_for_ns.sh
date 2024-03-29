#!/bin/bash

NODE_INTERFACE=enp24s0np0;
NAMESPACE_ID=ns;
# INSIDE_VETH=veth;
# OUTSIDE_VETH=veth;

host_ip_addr=$(ip -f inet addr show $NODE_INTERFACE | awk '/inet / {print $2}')
IFS='.' read ip1 ip2 ip3 ip4 <<< "$host_ip_addr"
fouth_octec=1
# third_octect=$ip3

in_veth_number=0
out_veth_number=0

# ns_ip=$ip1.$ip2.$ip3.$(($4 + $i))/16

for i in $(seq 1 1); do 

    # ns_ip_addr=$ip1.$ip2.$ip3.$(($fouth_octec + $i))/16
    ns_ip_addr=$ip1.$ip2.$ip3.$(($fouth_octec + $i))/8
    # ns_ip_addr=$ip1.$ip2.2.$(($fouth_octec + $i))/16
    echo $ns_ip_addr
    
    NEW_NAMESPACE_ID="$NAMESPACE_ID$i"
    echo $NEW_NAMESPACE_ID

    in_veth_number=`expr $i + 1`
    # out_veth_number=`expr $in_veth_number + 10`
    out_veth_number=`expr $i + 1`

    INSIDE_VETH="vethin$in_veth_number"
    OUTSIDE_VETH="vethout$out_veth_number"
    echo $INSIDE_VETH
    echo $OUTSIDE_VETH

    sudo ip netns add $NEW_NAMESPACE_ID
    sudo ip link add $INSIDE_VETH type veth peer name $OUTSIDE_VETH
    sudo ip link set $INSIDE_VETH netns $NEW_NAMESPACE_ID
    sudo ip netns exec $NEW_NAMESPACE_ID ip link set dev $INSIDE_VETH up
    sudo ip link set dev $OUTSIDE_VETH up
    
    sudo ip netns exec $NEW_NAMESPACE_ID ip addr add $ns_ip_addr dev $INSIDE_VETH
    sudo ip netns exec $NEW_NAMESPACE_ID ip link set arp off dev $INSIDE_VETH
    sudo ip netns exec $NEW_NAMESPACE_ID ethtool -K $INSIDE_VETH tx off
    sudo ip netns exec $NEW_NAMESPACE_ID ip link set $INSIDE_VETH mtu 1400
    sudo ip link set $OUTSIDE_VETH mtu 1400

    echo "========================================="
done 
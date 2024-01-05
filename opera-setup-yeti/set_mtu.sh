#!/bin/sh

MTU_VETH=3500

sudo ip netns exec ns1 ip link set vethin2 mtu $MTU_VETH
sudo ip netns exec ns2 ip link set vethin3 mtu $MTU_VETH
sudo ip netns exec ns3 ip link set vethin4 mtu $MTU_VETH
sudo ip netns exec ns4 ip link set vethin5 mtu $MTU_VETH
sudo ip netns exec ns5 ip link set vethin6 mtu $MTU_VETH
sudo ip netns exec ns6 ip link set vethin7 mtu $MTU_VETH
sudo ip netns exec ns7 ip link set vethin8 mtu $MTU_VETH
sudo ip netns exec ns8 ip link set vethin9 mtu $MTU_VETH

sudo ip link set vethout12 mtu $MTU_VETH
sudo ip link set vethout13 mtu $MTU_VETH
sudo ip link set vethout14 mtu $MTU_VETH
sudo ip link set vethout15 mtu $MTU_VETH
sudo ip link set vethout16 mtu $MTU_VETH
sudo ip link set vethout17 mtu $MTU_VETH
sudo ip link set vethout18 mtu $MTU_VETH
sudo ip link set vethout19 mtu $MTU_VETH

# sudo ip link set ens2np0 mtu 3890


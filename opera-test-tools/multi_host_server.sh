#!/bin/bash

# server is running 
num_namespaces=0

bandwidth="50000M"

for arg in "$@"
do
case $arg in
    -n|--number-of-ns)
        shift
        num_namespaces=$1
        shift
        ;;
    -i|--interface)
        shift
        interface=$1
        shift
        ;;
    -s|--ip)
        shift
        ip=$1
        shift
        ;;
    -v|--ip)
        shift
        veth=$1
        shift
        ;;
esac
done

server=$ip
nic_local_numa_node=$(cat /sys/class/net/$interface/device/numa_node)

myArray=("blue" "red" "ns12" "ns13" "ns15" "ns16" "ns17" "ns18" "ns19" "ns20" "ns21" "ns22" "ns23" "ns24")

x=0
for i in $(seq $veth $num_namespaces);
do
    port=$(echo "5100+$x" | bc)
    numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -s $server -p $port &
    x=$(echo "1+$x" | bc)
done




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
esac
done


nic_local_numa_node=$(cat /sys/class/net/$interface/device/numa_node)

myArray=("ns1" "ns2" "ns3" "ns4" "ns5" "ns6" "ns7" "ns8")
serverList=("10.20.2.2" "10.20.2.3" "10.20.2.4" "10.20.2.5" "10.20.2.6" "10.20.2.7" "10.20.2.8" "10.20.2.9")

cpu_core_id=$(echo "62" | bc)
port=$(echo "5100" | bc);
for i in $(seq 0 $num_namespaces);
do
    # cpu_core_id=$(echo "$cpu_core_id+2" | bc)
    # port=$(echo "5100+$i" | bc)
    numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -s ${serverList[$i]} -p $port &
    # sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$i]} iperf3 -s ${serverList[$i]} -p $port &
    port=$(echo "500+$port" | bc)
done


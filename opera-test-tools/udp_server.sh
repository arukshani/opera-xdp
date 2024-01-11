#!/bin/bash

# server is running 
num_namespaces=1
server="10.20.2.1"
bandwidth="40G"
nic_local_numa_node=$(cat /sys/class/net/enp175s0np1/device/numa_node)

for arg in "$@"
do
case $arg in
    -n|--number-of-ns)
        shift
        num_namespaces=$1
        shift
        ;;
esac
done


myArray=("ns1" "ns2" "ns3" "ns4" "ns5" "ns6" "ns7" "ns8")
serverList=("10.20.2.2" "10.20.2.3" "10.20.2.4" "10.20.2.5" "10.20.2.6" "10.20.2.7" "10.20.2.8" "10.20.2.9")

cpu_core_id=$(echo "65" | bc)
port=$(echo "5100" | bc);

output=$(
for i in $(seq 0 $num_namespaces);
do
    sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$i]} iperf -s -p $port -u -l 3400 &
    port=$(echo "500+$port" | bc)
    cpu_core_id=$(echo "$cpu_core_id+1" | bc)
done
)

#!/bin/bash

# server is running 
num_namespaces=0
server="10.20.2.2"
bandwidth="50000M"
nic_local_numa_node=$(cat /sys/class/net/ens2np0/device/numa_node)

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


myArray=("c1" "c2" "c3" "c4" "c5" "c6" "c7")
serverList=("10.20.2.2" "10.20.2.3" "10.20.2.4" "10.20.2.5" "10.20.2.6" "10.20.2.7" "10.20.2.8")

cpu_core_id=$(echo "12" | bc)
port=$(echo "5100" | bc);
for i in $(seq 0 $num_namespaces);
do
    docker exec -i ${myArray[$i]} iperf3 -s ${serverList[$i]} -p $port &
    port=$(echo "500+$port" | bc)
    cpu_core_id=$(echo "$cpu_core_id+2" | bc)
done


# sender_total_tput=$(echo $output | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
# echo "parallel: $num_namespaces, sender: $sender_total_tput"
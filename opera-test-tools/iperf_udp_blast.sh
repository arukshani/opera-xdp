#!/bin/bash

# no server is running on the other side
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

myArray=("ns1" "ns2" "ns3" "ns4" "ns5" "ns6" "ns7" "ns8")
serverList=("10.20.2.2" "10.20.2.3" "10.20.2.4" "10.20.2.5" "10.20.2.6" "10.20.2.7" "10.20.2.8" "10.20.2.9")

cpu_core_id=$(echo "63" | bc)
output=$(
for i in $(seq 0 $num_namespaces); do
    # echo ${myArray[$i]}
    port=$(echo "5100+$i" | bc);
    cpu_core_id=$(echo "$cpu_core_id+2" | bc)
    # sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$i]} iperf -c $server -p $port -u -t 30 -b $bandwidth &
    # sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$i]} iperf -c $server -p $port -u -t 30 -b $bandwidth &
    sudo numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf -c ${serverList[$i]} -p $port -u -t 30 -b $bandwidth -P 2 &
    # sudo numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf -c $server -p $port -u -t 30 -b $bandwidth &
    
done
)

# echo $output
sender_total_tput=$(echo $output | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
echo "parallel: $num_namespaces, sender: $sender_total_tput"
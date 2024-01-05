#!/bin/bash

# server is running 
num_namespaces=0
server="10.20.2.2"
bandwidth="50000M"
nic_local_numa_node=$(cat /sys/class/net/enp65s0f0np0/device/numa_node)

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

# myArray=("blue" "red" "ns12" "ns13" "ns15" "ns16" "ns17" "ns18" "ns19" "ns20" "ns21" "ns22" "ns23" "ns24")
# myArray=("cr1" "cr2" "cr3" "cr4" "cr5" "cr6" "cr7" "cr8")

# output=$(
# for i in $(seq 0 $num_namespaces); do
#     # echo ${myArray[$i]}
#     sudo numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf -c $server -u -t 60 -b $bandwidth &
# done
# )

# # echo $output
# sender_total_tput=$(echo $output | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
# echo "parallel: $num_namespaces, sender: $sender_total_tput"


# cpu_core_id=$(echo "63" | bc)
# cpu_core_id=$(echo "62" | bc)

myArray=("ns1" "ns2" "ns3" "ns4" "ns5" "ns6" "ns7" "ns8")
serverList=("10.20.2.2" "10.20.2.3" "10.20.2.4" "10.20.2.5" "10.20.2.6" "10.20.2.7" "10.20.2.8" "10.20.2.9")

cpu_core_id=$(echo "8" | bc)
port=$(echo "5100" | bc);
for i in $(seq 0 $num_namespaces);
do
    # cpu_core_id=$(echo "$cpu_core_id+2" | bc)
    # numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -s ${serverList[$i]} -p $port &
    sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$i]} iperf3 -s ${serverList[$i]} -p $port &
    port=$(echo "500+$port" | bc)
    # numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -s ${serverList[$i]} -p $port &
    cpu_core_id=$(echo "$cpu_core_id+2" | bc)
done


# sender_total_tput=$(echo $output | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
# echo "parallel: $num_namespaces, sender: $sender_total_tput"
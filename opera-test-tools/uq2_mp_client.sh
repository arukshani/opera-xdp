#!/bin/bash

# Actual server is running on the other side on root

num_namespaces=0
server="10.1.0.2"
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

# myArray=("blue" "red" "ns12" "ns13" "ns15" "ns16" "ns17" "ns18" "ns19" "ns20" "ns21" "ns22" "ns23" "ns24")

myArray=("ns1" "ns2" "ns3" "ns4" "ns5" "ns6" "ns7" "ns8")
serverList=("10.20.2.2" "10.20.2.3" "10.20.2.4" "10.20.2.5" "10.20.2.6" "10.20.2.7" "10.20.2.8" "10.20.2.9")


cpu_core_id=$(echo "8" | bc)
port=$(echo "5100" | bc)
ns_count=$(echo "0" | bc)
output=$(
# for i in $(seq 0 $num_namespaces); do
for i in $(seq 0 0); do
    # numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -c ${serverList[$i]} -p $port -t 30 -f g -P 2 &
    sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$ns_count]} iperf3 -c ${serverList[$ns_count]} -p $port -t 30 -f g -P 2 &
    port=$(echo "500+$port" | bc)
    cpu_core_id=$(echo "$cpu_core_id+2" | bc)
    # ns_count=$(echo "$ns_count+1" | bc)
    sudo taskset --cpu-list $cpu_core_id ip netns exec ${myArray[$ns_count]} iperf3 -c ${serverList[$ns_count]} -p $port -t 30 -f g -P 2 &
    # numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -c ${serverList[$i]} -p $port -t 30 -f g -P 1 &
    port=$(echo "500+$port" | bc)
    cpu_core_id=$(echo "$cpu_core_id+2" | bc)
done
)

# inter_out=$(echo $output| grep -o -P '(?<=sender).*?(?=receiver)')
# # echo $inter_out
# sender_total_tput=$(echo $inter_out | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
# echo $sender_total_tput

# echo $output
inter_out=$(echo $output| grep -o -P '(?<=sender).*?(?=receiver)')
# echo $inter_out
# inter_out_2=$(echo $inter_out| grep -oP 'SUM\K(?:(?!Gbits).)*')
inter_out_2=$(echo $inter_out| grep -oP 'SUM\s*\K(?:(?!\s+Gbits).)*')
# echo $inter_out_2
inter_out_3=$(echo $inter_out_2| grep -Po 'GBytes\s*[0-9.]*')
# echo $inter_out_3
inter_out_4=$(echo $inter_out_3 | grep -Po 'GBytes\s*\K\d\S*' | awk '{sum+=$1} END {print sum}')
echo $inter_out_4
# sender_total_tput=$(echo $inter_out_3 | grep -Po "(?=GBytes)[0-9]*" | awk '{sum+=$1} END {print sum}')
# echo $sender_total_tput

# '[0-9.]*(?= Gbits/sec)'
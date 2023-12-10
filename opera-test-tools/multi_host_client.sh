#!/bin/bash

# Actual server is running on the other side on root

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
    -s1|--ip1)
        shift
        ip1=$1
        shift
        ;;
    -s2|--ip2)
        shift
        ip2=$1
        shift
        ;;
    -v|--veth)
        shift
        veth=$1
        shift
        ;;
esac
done

server1=$ip1
server2=$ip2
nic_local_numa_node=$(cat /sys/class/net/$interface/device/numa_node)

myArray=("blue" "red" "ns12" "ns13" "ns15" "ns16" "ns17" "ns18" "ns19" "ns20" "ns21" "ns22" "ns23" "ns24")
serverArray=("10.1.0.2" "10.1.0.2" "10.1.0.3" "10.1.0.3" "10.1.0.4" "10.1.0.4")

x=0
output=$(
for i in $(seq 0 $num_namespaces); do
    port=$(echo "5100+$x" | bc);
    numactl -N $nic_local_numa_node ip netns exec ${myArray[$i]} iperf3 -c ${serverArray[$i]} -p $port -t 30 -f g &
    x=$(echo "1+$x" | bc)
    if [ "$port" -eq 5101 ]; then
        port=5100
        x=0
    fi
done
)

inter_out=$(echo $output| grep -o -P '(?<=sender).*?(?=receiver)')
sender_total_tput=$(echo $inter_out | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
echo $sender_total_tput
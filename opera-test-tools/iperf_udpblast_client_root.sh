#!/bin/bash

# Actual server is running on the other side on root

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

# myArray=("blue" "red" "ns12" "ns13" "ns15" "ns16" "ns17" "ns18" "ns19" "ns20" "ns21" "ns22" "ns23" "ns24")

cpu_core_id=$(echo "65" | bc)
port=$(echo "5100" | bc);
output=$(
for i in $(seq 0 $num_namespaces); do
    iperf -c $server -p $port -u -t 30 -b $bandwidth -f g -l 3500 &
    # iperf3 -c $server -p $port -u -t 30 -b $bandwidth -f g -l 3500 &
    port=$(echo "500+$port" | bc)
    # numactl -N $nic_local_numa_node iperf -c $server -p $port -u -t 60 -b $bandwidth -f g -l 3500 &
    # sudo taskset --cpu-list $cpu_core_id iperf -c $server -p $port -u -t 30 -b $bandwidth -f g -l 3500 &
    # iperf -c $server -p $port -u -t 30 -b $bandwidth -f g -l 3500 &
    cpu_core_id=$(echo "$cpu_core_id+1" | bc)
done
)

# echo $output
inter_out=$(echo $output | grep -oP "Server\s\K.*")
inter2_out=$(echo $inter_out | sed -r ':a;s/([^\n]*)(ID)[^\n]+(Sent)/\1\n\2\3/;ta;s/\n//g')
echo $inter2_out
sender_total_tput=$(echo $inter2_out | grep -Po '[0-9.]*(?= Gbits/sec)' | awk '{sum+=$1} END {print sum}')
echo $sender_total_tput 
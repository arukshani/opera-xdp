#!/bin/bash

# echo $1 $2
# sudo ip netns exec blue arp -i veth0 -s $1 $2
# sudo ip netns exec red arp -i veth2 -s $1 $3

num_namespaces=0
node=$(hostname)
# echo $node

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
myArray=("c1" "c2" "c3" "c4" "c5" "c6" "c7")

last_octect=2

for i in $(seq 0 $num_namespaces); do
    
    exlude_ip="172.17.0.$last_octect"
    # echo $exlude_ip
    ip=$(docker exec -i ${myArray[$i]} ifconfig | awk '/inet / {print $2}' | grep -v $exlude_ip | grep -v '127.0.0.1')
    ether=$(docker exec -i ${myArray[$i]} ifconfig | awk '/ether / {print $2}')
    iface=$(docker exec -i ${myArray[$i]} netstat -i | grep '^[a-z]' | awk '{print $1}' | grep -v 'lo' | grep -v 'eth0')
    # echo $i, $node, ${myArray[$i]}, $iface, $ip, $ether
    last_octect=$(echo "$last_octect+1" | bc);
    # echo $last_octect
    echo $i, $node, ${myArray[$i]}, $iface, $ip, $ether >> DOCKER$node.csv
done

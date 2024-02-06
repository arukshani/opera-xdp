#!/bin/bash

. clock_test.config

host=$(hostname -s)

for arg in "$@"
do
case $arg in
    -f|--file_name)
        shift
        file_name=$1
        shift
        ;;
    -i|--interface)
        shift
        interface=$1
        shift
        ;;
esac
done

pcap_name="${host}-${file_name}.pcap"
echo $pcap_name

# sudo tcpdump -i $INTERFACE udp port 8000 -XAvvv
sudo tcpdump -i $INTERFACE -j adapter_unsynced -w /opt/timestamp_test/$pcap_name
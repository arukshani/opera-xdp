### This is version 5 

```
sudo ip netns exec blue bash
sudo ethtool -L ens4 combined 1

iperf3 -c 10.1.0.2 -p 5000  
iperf3 -s 10.1.0.2 -p 5000 

sudo ./iperf_udp_ns_server.sh -n 0
sudo ./iperf_udp_ns_client.sh -n 0

sudo ./iperf_tcp_ns_server.sh -n 0
sudo ./iperf_tcp_ns_client.sh -n 0
sudo ./mp_iperf_tcp_ns_client.sh -n 0

sudo taskset --cpu-list 15 ./opera_emulator 192.168.1.1 configs/node-1-link.csv /dev/ptp0 120 1 1 
sudo taskset --cpu-list 15 ./opera_emulator 192.168.1.2 configs/node-2-link.csv /dev/ptp0 120 1 1 
```
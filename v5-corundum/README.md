
### This is version 5 refactoring: corundum test
```
sudo taskset --cpu-list 32 ./sw_corundum 10.20.2.1 120 8 16
sudo taskset --cpu-list 32 ./sw_corundum 10.20.2.2 120 8 16 

sudo ./iperf_tcp_ns_client.sh -n 0 -i ens2np0 -s 10.20.2.2
sudo ./iperf_tcp_ns_server.sh -n 0 -i ens2np0 -s 10.20.2.2

iperf3 -c 10.20.2.2 -p 5000
iperf3 -s 10.20.2.2 -p 5000

sudo ethtool -L ens2np0 rx 16
sudo ethtool -L ens2np0 tx 16

sudo ip link set dev ens2np0 up
sudo ip link set dev ens2np0 down

sudo set_irq_affinity.sh ens2np0

```
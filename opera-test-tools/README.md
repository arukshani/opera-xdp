```
sudo ./iperf_tcp_ns_client.sh -n 0 -i enp202s0f0np0 -s 192.168.1.2
sudo ./iperf_tcp_ns_server.sh -n 0 -i enp202s0f0np0 -s 192.168.1.2

sudo ./iperf_tcp_ns_client.sh -n 0 -i ens4 -s 10.1.0.2
sudo ./iperf_tcp_ns_server.sh -n 0 -i ens4 -s 10.1.0.2
```

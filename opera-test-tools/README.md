```
sudo ./iperf_tcp_ns_client.sh -n 0 -i enp202s0f0np0 -s 192.168.1.2
sudo ./iperf_tcp_ns_server.sh -n 0 -i enp202s0f0np0 -s 192.168.1.2

sudo ./iperf_tcp_ns_client.sh -n 0 -i ens4 -s 10.1.0.4
sudo ./iperf_tcp_ns_server.sh -n 0 -i ens4 -s 10.1.0.4


<!-- sudo ./iperf_tcp_ns_client.sh -n 0 -i ens4 -s1 10.1.0.2 -s2 10.1.0.3
sudo ./iperf_tcp_ns_server.sh -n 0 -i ens4 -s 10.1.0.2
sudo ./iperf_tcp_ns_server.sh -n 0 -i ens4 -s 10.1.0.3 -->


sudo ./multi_host_client.sh -i ens4 -n 1
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.2 -v 0
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.3 -v 1

sudo ./multi_host_server.sh -i ens4 -s 10.1.0.2 -v 0 -n 1
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.3 -v 2 -n 3
sudo ./multi_host_client.sh -i ens4 -n 3

sudo ./multi_host_server.sh -i ens4 -s 10.1.0.2 -v 0 -n 2
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.3 -v 3 -n 5
sudo ./multi_host_client.sh -i ens4 -n 5

sudo ./multi_host_server.sh -i ens4 -s 10.1.0.2 -v 0 -n 3
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.3 -v 4 -n 7
sudo ./multi_host_client.sh -i ens4 -n 7

```

```
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.2 -v 0 -n 0
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.3 -v 1 -n 1
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.4 -v 2 -n 2
sudo ./multi_host_client.sh -i ens4 -n 2

sudo ./multi_host_server.sh -i ens4 -s 10.1.0.2 -v 0 -n 1
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.3 -v 2 -n 3
sudo ./multi_host_server.sh -i ens4 -s 10.1.0.4 -v 4 -n 5
sudo ./multi_host_client.sh -i ens4 -n 5

```


###########iperf 2

```
sudo ./iperf_udpblast_client_root.sh -n 0
sudo ./iperf_udpblast_server_root.sh -n 0
```
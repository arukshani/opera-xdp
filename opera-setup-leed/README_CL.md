###VS Code stuff
```
sudo chown -R dathapathu /opt/opera-xdp/

```

```

./opera-setup-leed/setup_master.sh

sudo ip link set dev enp65s0f0np0 down
sudo ip addr del 10.10.1.1/24 dev enp65s0f0np0
sudo ip addr del 10.10.1.2/24 dev enp65s0f0np0

sudo ip addr add 10.20.1.1/16 dev enp65s0f0np0
sudo ip addr add 10.20.2.1/16 dev enp65s0f0np0
sudo ip link set dev enp65s0f0np0 up
//sudo ip link set enp65s0f0np0 mtu 3490


./opera-setup-leed/setup_worker.sh
./opera-setup-leed/unique_ip_for_ns.sh

cd opera-setup-leed
python3 setup_mac.py

./get_veth_info.sh -n 7

python3 setup_all_to_all_arp.py configs/NSleed-01.csv //node2
python3 setup_all_to_all_arp.py configs/NSleed-02.csv //node1

sudo ethtool -L enp175s0np1 combined 1
sudo ethtool -L enp24s0np0 rx 256
sudo ethtool -L enp24s0np0 tx 256
sudo ./set_irq_affinity.sh enp175s0np1

enp24s0np0


```

```
sudo ip netns exec ns1 bash

iperf3 -c 10.20.2.1 -p 5000
iperf3 -s 10.20.2.1 -p 5000
```

```
sudo dos2unix set_irq_affinity.sh
sudo dos2unix common_irq_affinity.sh
sudo dos2unix show_irq_affinity.sh
```

